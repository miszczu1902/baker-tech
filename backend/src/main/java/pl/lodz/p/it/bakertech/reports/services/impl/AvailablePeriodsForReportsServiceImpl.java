package pl.lodz.p.it.bakertech.reports.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.exceptions.TransactionTimeoutException;
import pl.lodz.p.it.bakertech.reports.dto.AvailableDatesDTO;
import pl.lodz.p.it.bakertech.reports.repositories.AvailablePeriodsForReportsRepository;
import pl.lodz.p.it.bakertech.reports.services.AvailablePeriodsForReportsService;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
@Retryable(
        retryFor = TransactionTimeoutException.class,
        maxAttemptsExpression = "${bakertech.transaction.retry}",
        backoff = @Backoff(delayExpression = "${bakertech.transaction.retry.delay}")
)
@PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
public class AvailablePeriodsForReportsServiceImpl extends CommonService implements AvailablePeriodsForReportsService {
    private final AvailablePeriodsForReportsRepository availablePeriodsForReportsRepository;

    public AvailablePeriodsForReportsServiceImpl(@Value("${bakertech.keycloak.realm}")String realmName,
                                                 Keycloak keycloak,
                                                 KeycloakMapper keycloakMapper,
                                                 ETagGenerator eTagGenerator,
                                                 AvailablePeriodsForReportsRepository availablePeriodsForReportsRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.availablePeriodsForReportsRepository = availablePeriodsForReportsRepository;
    }

    @Override
    public AvailableDatesDTO availablePeriodsForReports() {
        var result = availablePeriodsForReportsRepository.findDistinctExecutionPeriods()
                .stream()
                .map(row -> "%s-%s".formatted(row.getAvailableYear(), row.getAvailableMonth()))
                .toList();
        return new AvailableDatesDTO(result);
    }
}
