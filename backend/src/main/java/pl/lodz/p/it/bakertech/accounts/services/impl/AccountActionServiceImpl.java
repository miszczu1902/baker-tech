package pl.lodz.p.it.bakertech.accounts.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.GroupRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;
import pl.lodz.p.it.bakertech.accounts.repositories.AccessLevelRepository;
import pl.lodz.p.it.bakertech.utils.mappers.KeycloakMapper;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.accounts.services.AccountActionService;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Administrator;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.security.Roles;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public class AccountActionServiceImpl extends CommonService implements AccountActionService {
    private final AccountRepository accountRepository;
    private final AccessLevelRepository accessLevelRepository;

    protected AccountActionServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                       Keycloak keycloak,
                                       KeycloakMapper keycloakMapper,
                                       AccountRepository accountRepository,
                                       AccessLevelRepository accessLevelRepository) {
        super(realmName, keycloak, keycloakMapper);
        this.accountRepository = accountRepository;
        this.accessLevelRepository = accessLevelRepository;
    }

    @Override
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public void grantAccessLevelToAccount(final Long id, final AccessLevelsDTO assignAccessLevel) {
        execute(() -> {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            Optional<Account> account = accountRepository.findById(id);

            if (account.isPresent()) {
                Account accountToUpdate = account.get();
                if (!username.equals(accountToUpdate.getUsername())) {
                    Set<String> accessLevels = accountToUpdate.getAccessLevels()
                            .stream()
                            .map(AccessLevel::getAccessLevelName)
                            .collect(Collectors.toSet());
                    Set<String> missingAccessLevels = assignAccessLevel.accessLevels()
                            .stream()
                            .filter(accessLevelName -> !accessLevels.contains(accessLevelName))
                            .collect(Collectors.toSet());

                    if (missingAccessLevels.isEmpty() || accessLevels.contains(Roles.CLIENT)) {
                        throw AppException.createCannotAssignAccessLevelsException();
                    } else {
                        Set<AccessLevel> accessLevelsToAssign = missingAccessLevels.stream()
                                .map(accessLevel -> accessLevel.equals(Roles.ADMINISTRATOR)
                                                ? accessLevelRepository.saveAndFlush(new Administrator(accountToUpdate))
                                                : accessLevelRepository.saveAndFlush(new Serviceman(accountToUpdate)))
                                .collect(Collectors.toSet());
                        accountToUpdate.getAccessLevels().addAll(accessLevelsToAssign);
                        accountRepository.saveAndFlush(accountToUpdate);

                        String userId = getKeycloakUserByUsername(accountToUpdate.getUsername()).getId();
                        List<String> missingGroups = missingAccessLevels.stream()
                                .filter(accessLevel -> Roles.getAuthenticatedRolesWithGroups().containsKey(accessLevel))
                                .map(accessLevel -> Roles.getAuthenticatedRolesWithGroups().get(accessLevel))
                                .toList();
                        realmResource.groups()
                                .groups()
                                .stream()
                                .filter(group -> missingGroups.contains(group.getName()))
                                .map(GroupRepresentation::getId)
                                .forEach(group -> getKeycloakUserByUserId(userId).joinGroup(group));
                    }
                } else {
                    throw AppException.createCannotChangeAccessLevelSelfException();
                }
            } else {
                throw AppException.createCannotAssignAccessLevelsException();
            }
        });
    }

    @Override
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public void revokeAccessLevelFromAccount(final Long id, final AccessLevelsDTO removeAccessLevel) {
        execute(() -> {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            Optional<Account> account = accountRepository.findById(id);

            if (account.isPresent()) {
                Account accountToUpdate = account.get();
                if (accountToUpdate.getAccessLevels().size() == 1) {
                    throw AppException.createCannotRemoveOnlyOneAssignedAccessLevelToAccountException();
                }

                if (!username.equals(accountToUpdate.getUsername())) {
                    Set<String> accessLevels = accountToUpdate.getAccessLevels()
                            .stream()
                            .map(AccessLevel::getAccessLevelName)
                            .collect(Collectors.toSet());
                    Set<String> containedAccessLevels = removeAccessLevel.accessLevels()
                            .stream()
                            .filter(accessLevels::contains)
                            .collect(Collectors.toSet());

                    if (containedAccessLevels.isEmpty() || accessLevels.contains(Roles.CLIENT)) {
                        throw AppException.createCannotAssignAccessLevelsException();
                    } else {
                       containedAccessLevels.forEach(accessLevel -> accessLevelRepository
                               .findAccessLevelByAccountIdAndAccessLevelName(accountToUpdate.getId(), accessLevel)
                               .ifPresent(level -> {
                                   accountToUpdate.getAccessLevels().remove(level);
                                   accessLevelRepository.delete(level);
                               }));

                        String userId = getKeycloakUserByUsername(accountToUpdate.getUsername()).getId();
                        List<String> groupsToRemove = containedAccessLevels.stream()
                                .filter(accessLevel -> Roles.getAuthenticatedRolesWithGroups().containsKey(accessLevel))
                                .map(accessLevel -> Roles.getAuthenticatedRolesWithGroups().get(accessLevel))
                                .toList();
                        realmResource.groups()
                                .groups()
                                .stream()
                                .filter(group -> groupsToRemove.contains(group.getName()))
                                .map(GroupRepresentation::getId)
                                .forEach(group -> getKeycloakUserByUserId(userId).leaveGroup(group));
                    }
                } else {
                    throw AppException.createCannotChangeAccessLevelSelfException();
                }
            } else {
                throw AppException.createCannotAssignAccessLevelsException();
            }
        });
    }

    @Override
    @PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
    public void changeAccountStatus(final Long id) {
        execute(() -> {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            accountRepository.findById(id)
                    .ifPresent(accountToUpdate -> {
                        if (!username.equals(accountToUpdate.getUsername())) {
                            accountToUpdate.setIsActive(!accountToUpdate.getIsActive());
                            accountRepository.saveAndFlush(accountToUpdate);

                            UserRepresentation keycloakUser = getKeycloakUserByUsername(accountToUpdate.getUsername());
                            keycloakUser.setEnabled(!keycloakUser.isEnabled());
                            getKeycloakUserByUserId(keycloakUser.getId()).update(keycloakUser);
                        } else {
                            throw AppException.createCannotChangeStatusForSelfAccountException();
                        }
                    });
        });
    }
}