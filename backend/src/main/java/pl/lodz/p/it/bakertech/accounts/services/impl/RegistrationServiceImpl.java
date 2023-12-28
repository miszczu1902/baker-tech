package pl.lodz.p.it.bakertech.accounts.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.ConfirmAccountDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.client.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.listeners.events.RegistrationEvent;
import pl.lodz.p.it.bakertech.utils.mappers.AccountAndAccessLevelMapper;
import pl.lodz.p.it.bakertech.utils.mappers.KeycloakMapper;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountConfirmationTokenRepository;
import pl.lodz.p.it.bakertech.accounts.services.RegistrationService;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.interceptors.Interception;
import pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.AccountConfirmationToken;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;
import pl.lodz.p.it.bakertech.utils.RandomValueGenerator;

import java.time.LocalDateTime;
import java.util.Optional;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.TIMEZONE;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public class RegistrationServiceImpl extends CommonService implements RegistrationService {
    private final AccountRepository accountRepository;
    private final AccountConfirmationTokenRepository accountConfirmationTokenRepository;
    private final AccountAndAccessLevelMapper accountAndAccessLevelMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Autowired
    public RegistrationServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                   Keycloak keycloak,
                                   KeycloakMapper keycloakMapper,
                                   AccountRepository accountRepository,
                                   AccountConfirmationTokenRepository accountConfirmationTokenRepository,
                                   AccountAndAccessLevelMapper accountAndAccessLevelMapper,
                                   ApplicationEventPublisher eventPublisher) {
        super(realmName, keycloak, keycloakMapper);
        this.accountRepository = accountRepository;
        this.accountConfirmationTokenRepository = accountConfirmationTokenRepository;
        this.accountAndAccessLevelMapper = accountAndAccessLevelMapper;
        this.eventPublisher = eventPublisher;
    }

    @PreAuthorize("hasAnyRole(@Roles.GUEST, @Roles.ADMINISTRATOR)")
    private String prepareAccountConfirmationToken() {
        String accountConfirmationToken;
        do {
            accountConfirmationToken = RandomValueGenerator.generateConfirmationToken();
        } while (accountConfirmationTokenRepository.existsAccountConfirmationTokenByConfirmationToken(accountConfirmationToken));
        return accountConfirmationToken;
    }

    @PreAuthorize("hasAnyRole(@Roles.GUEST, @Roles.SERVICEMAN)")
    private void confirmAccount(final AccountConfirmationToken accountConfirmationToken) {
        Account account = accountConfirmationToken.getAccount();
        account.setIsActive(true);
        accountRepository.saveAndFlush(account);
        accountConfirmationTokenRepository.delete(accountConfirmationToken);

        UserRepresentation keycloakUser = getKeycloakUserByUsername(account.getUsername());
        keycloakUser.setEnabled(true);
        keycloakUser.setEmailVerified(true);
        realmResource.users().get(keycloakUser.getId()).update(keycloakUser);
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.GUEST, @Roles.ADMINISTRATOR)")
    public String registerAccount(final RegisterAccountDTO account) {
        return execute(() -> {
            final Account accountToRegistration = accountAndAccessLevelMapper.accountEntityFromRegisterAccountDTO(account);
            accountToRegistration.getPersonalData().setId(accountToRegistration);
            accountRepository.saveAndFlush(accountToRegistration);

            final String confirmationToken = prepareAccountConfirmationToken();
            accountConfirmationTokenRepository.saveAndFlush(
                    new AccountConfirmationToken(confirmationToken, LocalDateTime.now(TIMEZONE).plusDays(1), accountToRegistration));

            AccessLevel accessLevel = accountToRegistration.getAccessLevels()
                    .stream()
                    .findFirst()
                    .orElseThrow(AppException::createRegistrationException);
            String password = accessLevel instanceof Client ? ((RegisterClientDTO) account).getPassword() : RandomValueGenerator.generateRandomPassword();

            final UserRepresentation keycloakUser = keycloakMapper.accessLevelEntityToKeycloakUserRepresentation(accessLevel, password);
            if (realmResource.users().create(keycloakUser).getStatus() == 201) {
                if (accessLevel instanceof Client) {
                    eventPublisher.publishEvent(new RegistrationEvent(confirmationToken, account.getLanguage(), account.getEmail()));
                } else {
                    eventPublisher.publishEvent(new RegistrationEvent(
                            confirmationToken,
                            account.getLanguage(),
                            account.getEmail(),
                            account.getUsername(),
                            password));
                }
                return account.getUsername();
            }
            throw AppException.createKeycloakException();
        });
    }

    @Override
    @PreAuthorize("hasRole(@Roles.GUEST)")
    public void confirmAccountRegistration(final ConfirmAccountDTO confirmAccount) {
        execute(() -> {
            Optional<AccountConfirmationToken> confirmationTokenOptional = accountConfirmationTokenRepository
                    .findByConfirmationToken(confirmAccount.confirmationToken());

            if (confirmationTokenOptional.isPresent()) {
                confirmAccount(confirmationTokenOptional.get());
                Account account = confirmationTokenOptional.get().getAccount();

                account.setIsActive(true);
                accountRepository.saveAndFlush(account);
                accountConfirmationTokenRepository.delete(confirmationTokenOptional.get());
            } else {
                throw AppException.createRegistrationException();
            }
        });
    }
}