package pl.lodz.p.it.bakertech.accounts.services.impl;

import jakarta.ws.rs.core.Response;
import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountConfirmationTokenRepository;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountRepository;
import pl.lodz.p.it.bakertech.accounts.services.AccountScheduleService;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.interceptors.schedule.ScheduledInterception;
import pl.lodz.p.it.bakertech.model.accounts.AccountConfirmationToken;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.util.List;

import static pl.lodz.p.it.bakertech.utils.SchedulePeriods.PER_ONE_MINUTE;

@Service
@ScheduledInterception
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public class AccountScheduleServiceImpl extends CommonService implements AccountScheduleService {
    private final AccountRepository accountRepository;
    private final AccountConfirmationTokenRepository accountConfirmationTokenRepository;

    @Autowired
    public AccountScheduleServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                      Keycloak keycloak,
                                      KeycloakMapper keycloakMapper,
                                      ETagGenerator eTagGenerator,
                                      AccountRepository accountRepository,
                                      AccountConfirmationTokenRepository accountConfirmationTokenRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.accountRepository = accountRepository;
        this.accountConfirmationTokenRepository = accountConfirmationTokenRepository;
    }

    @Override
    @Scheduled(fixedRateString = PER_ONE_MINUTE)
    public void recognizeInactivatedAccounts() {
        List<AccountConfirmationToken> unconfirmedAccounts = accountConfirmationTokenRepository.findAll();
        if (!unconfirmedAccounts.isEmpty()) {
            unconfirmedAccounts.forEach(accountConfirmationToken -> {
                String username = accountConfirmationToken.getAccount().getUsername();

                accountRepository.delete(accountConfirmationToken.getAccount());
                accountConfirmationTokenRepository.delete(accountConfirmationToken);

                try (Response response = realmResource.users().delete(getKeycloakUserByUsername(username).getId())) {
                    if (response.getStatus() != 204 && response.getStatus() != 200) {
                        throw AppException.createKeycloakException();
                    }
                } catch (Exception e) {
                    throw AppException.createKeycloakException(e.getCause());
                }
            });
        }
    }
}
