package pl.lodz.p.it.bakertech.accounts.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.client.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.excpetions.RegistrationException;
import pl.lodz.p.it.bakertech.accounts.listeners.events.RegistrationEvent;
import pl.lodz.p.it.bakertech.exceptions.KeycloakException;
import pl.lodz.p.it.bakertech.exceptions.ObjectNotUniqueException;
import pl.lodz.p.it.bakertech.exceptions.TransactionTimeoutException;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.AccountAndAccessLevelMapper;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountConfirmationTokenRepository;
import pl.lodz.p.it.bakertech.accounts.services.RegistrationService;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.AccountConfirmationToken;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;
import pl.lodz.p.it.bakertech.utils.RandomValueGenerator;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.util.Optional;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "accountsTransactionManager"
)
@Retryable(
        retryFor = {TransactionTimeoutException.class, KeycloakException.class, ObjectNotUniqueException.class},
        maxAttemptsExpression = "${bakertech.transaction.retry}",
        backoff = @Backoff(delayExpression = "${bakertech.transaction.retry.delay}")
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
                                   ETagGenerator eTagGenerator,
                                   AccountRepository accountRepository,
                                   AccountConfirmationTokenRepository accountConfirmationTokenRepository,
                                   AccountAndAccessLevelMapper accountAndAccessLevelMapper,
                                   ApplicationEventPublisher eventPublisher) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
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
    public Long registerAccount(final RegisterAccountDTO account) {
        Account accountToRegistration = accountAndAccessLevelMapper.accountEntityFromRegisterAccountDTO(account);
        accountToRegistration.getPersonalData().setId(accountToRegistration);
        accountToRegistration = accountRepository.saveAndFlush(accountToRegistration);

        final String confirmationToken = prepareAccountConfirmationToken();
        accountConfirmationTokenRepository.saveAndFlush(
                new AccountConfirmationToken(confirmationToken, DateUtility.nowWithTimestamp().plusDays(1), accountToRegistration));

        AccessLevel accessLevel = accountToRegistration.getAccessLevels()
                .stream()
                .findFirst()
                .orElseThrow(RegistrationException::createRegistrationException);
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
            return accountToRegistration.getId();
        }
        throw AppException.createKeycloakException();
    }

    @Override
    @PreAuthorize("hasRole(@Roles.GUEST)")
    public void confirmAccountRegistration(final String confirmationToken) {
        Optional<AccountConfirmationToken> confirmationTokenOptional = accountConfirmationTokenRepository
                .findByConfirmationTokenEquals(confirmationToken);
        if (confirmationTokenOptional.isPresent()) {
            confirmAccount(confirmationTokenOptional.get());
            Account account = confirmationTokenOptional.get().getAccount();
            account.setIsActive(true);
            accountRepository.saveAndFlush(account);
            accountConfirmationTokenRepository.delete(confirmationTokenOptional.get());

            UserRepresentation keycloakUserByUsername = getKeycloakUserByUsername(account.getUsername());
            keycloakUserByUsername.setEnabled(true);
            getKeycloakUserByUserId(keycloakUserByUsername.getId()).update(keycloakUserByUsername);
        } else {
            throw RegistrationException.createRegistrationException();
        }
    }
}
