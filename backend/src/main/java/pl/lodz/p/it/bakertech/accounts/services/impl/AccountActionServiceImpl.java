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
import pl.lodz.p.it.bakertech.accounts.excpetions.CannotAssignAccessLevelsException;
import pl.lodz.p.it.bakertech.accounts.excpetions.CannotChangeAccessLevelSelfException;
import pl.lodz.p.it.bakertech.accounts.excpetions.CannotChangeStatusForSelfAccountException;
import pl.lodz.p.it.bakertech.accounts.excpetions.CannotRemoveOnlyOneAssignedAccessLevelToAccountException;
import pl.lodz.p.it.bakertech.accounts.repositories.AccessLevelRepository;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.accounts.services.AccountActionService;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Administrator;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "accountsTransactionManager"
)
@PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
public class AccountActionServiceImpl extends CommonService implements AccountActionService {
    private final AccountRepository accountRepository;
    private final AccessLevelRepository accessLevelRepository;

    protected AccountActionServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                       Keycloak keycloak,
                                       KeycloakMapper keycloakMapper,
                                       ETagGenerator eTagGenerator,
                                       AccountRepository accountRepository,
                                       AccessLevelRepository accessLevelRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.accountRepository = accountRepository;
        this.accessLevelRepository = accessLevelRepository;
    }

    @Override
    public void manageAccessLevels(final Long id,
                                   final AccessLevelsDTO accessLevelsDTO,
                                   final boolean isGrant,
                                   final String ifMatch) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        accountRepository.findById(id)
                .ifPresent(accountToUpdate -> {
                    if (!ifMatch.equals(eTagGenerator.generateETagValue(accountToUpdate))) {
                        throw AppException.createContentWasChangedException();
                    } else if (accountToUpdate.getAccessLevels().size() == 1 && !isGrant) {
                        throw CannotRemoveOnlyOneAssignedAccessLevelToAccountException.createException();
                    } else if (accountToUpdate.getAccessLevels().size() == 2 && isGrant) {
                        throw CannotAssignAccessLevelsException.createException();
                    } else {
                        if (!username.equals(accountToUpdate.getUsername())) {
                            Set<String> accessLevels = accountToUpdate.getAccessLevels()
                                    .stream()
                                    .map(AccessLevel::getAccessLevelName)
                                    .collect(Collectors.toSet());
                            Set<String> targetAccessLevels = accessLevelsDTO.accessLevels()
                                    .stream()
                                    .filter(accessLevelName -> isGrant || accessLevels.contains(accessLevelName))
                                    .collect(Collectors.toSet());

                            if (targetAccessLevels.isEmpty() || (isGrant && accessLevels.contains(Roles.CLIENT))) {
                                throw CannotAssignAccessLevelsException.createException();
                            } else {
                                Set<AccessLevel> accessLevelsToManage = targetAccessLevels.stream()
                                        .map(accessLevel -> isGrant
                                                ? accessLevel.equals(Roles.ADMINISTRATOR)
                                                ? accessLevelRepository.saveAndFlush(new Administrator(accountToUpdate))
                                                : accessLevelRepository.saveAndFlush(new Serviceman(accountToUpdate))
                                                : accessLevelRepository
                                                .findAccessLevelByAccountIdAndAccessLevelName(accountToUpdate.getId(), accessLevel)
                                                .orElseThrow(CannotAssignAccessLevelsException::createException))
                                        .collect(Collectors.toSet());

                                if (isGrant) {
                                    accountToUpdate.getAccessLevels().addAll(accessLevelsToManage);
                                } else {
                                    accountToUpdate.getAccessLevels().removeAll(accessLevelsToManage);
                                }
                                accountRepository.saveAndFlush(accountToUpdate);

                                String userId = getKeycloakUserByUsername(accountToUpdate.getUsername()).getId();
                                List<String> targetGroups = targetAccessLevels.stream()
                                        .filter(accessLevel -> Roles.getAuthenticatedRolesWithGroups().containsKey(accessLevel))
                                        .map(accessLevel -> Roles.getAuthenticatedRolesWithGroups().get(accessLevel))
                                        .toList();
                                realmResource.groups()
                                        .groups()
                                        .stream()
                                        .filter(group -> targetGroups.contains(group.getName()))
                                        .map(GroupRepresentation::getId)
                                        .forEach(group -> {
                                            if (isGrant) {
                                                getKeycloakUserByUserId(userId).joinGroup(group);
                                            } else {
                                                getKeycloakUserByUserId(userId).leaveGroup(group);
                                            }
                                        });
                            }
                        } else {
                            throw CannotChangeAccessLevelSelfException.createException();
                        }
                    }
                });
    }

    @Override
    public void changeAccountStatus(final Long id, final String ifMatch) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        accountRepository.findById(id)
                .ifPresent(accountToUpdate -> {
                    if (ifMatch.equals(eTagGenerator.generateETagValue(accountToUpdate))) {
                        if (!username.equals(accountToUpdate.getUsername())) {
                            accountToUpdate.setIsActive(!accountToUpdate.getIsActive());
                            accountRepository.saveAndFlush(accountToUpdate);
                            UserRepresentation keycloakUser = getKeycloakUserByUsername(accountToUpdate.getUsername());
                            keycloakUser.setEnabled(!keycloakUser.isEnabled());
                            getKeycloakUserByUserId(keycloakUser.getId()).update(keycloakUser);
                        } else {
                            throw CannotChangeStatusForSelfAccountException.createException();
                        }
                    } else {
                        throw AppException.createContentWasChangedException();
                    }
                });
    }
}