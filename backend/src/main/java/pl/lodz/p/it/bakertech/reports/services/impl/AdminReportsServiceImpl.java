package pl.lodz.p.it.bakertech.reports.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
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
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.reports.dto.TextWithNumberReportDataDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.OrdersReportInfoDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;
import pl.lodz.p.it.bakertech.reports.repositories.AccessLevelReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.AdminReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.OrderReportsRepository;
import pl.lodz.p.it.bakertech.reports.services.AdminReportsService;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.math.BigDecimal;
import java.util.Optional;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.ROUNDING_PRECISION;

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
@PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
public class AdminReportsServiceImpl extends CommonService implements AdminReportsService {
    private final AdminReportsRepository adminReportsRepository;
    private final AccessLevelReportsRepository accessLevelReportsRepository;
    private final OrderReportsRepository orderReportsRepository;

    @Autowired
    public AdminReportsServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                   Keycloak keycloak,
                                   KeycloakMapper keycloakMapper,
                                   ETagGenerator eTagGenerator,
                                   AdminReportsRepository adminReportsRepository,
                                   AccessLevelReportsRepository accessLevelReportsRepository,
                                   OrderReportsRepository orderReportsRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.adminReportsRepository = adminReportsRepository;
        this.accessLevelReportsRepository = accessLevelReportsRepository;
        this.orderReportsRepository = orderReportsRepository;
    }

    @Override
    public PercentageOfOrdersDTO findPercentageOfOrdersByType(final Integer month, final Integer year) {
        var result = adminReportsRepository.findPercentageOfOrdersByTypeWithDefault(month, year);
        return new PercentageOfOrdersDTO(
                BigDecimal.valueOf(Optional.ofNullable(result.getNonWarrantyRepair()).orElse(0D)).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(Optional.ofNullable(result.getWarrantyRepair()).orElse(0D)).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(Optional.ofNullable(result.getConservation()).orElse(0D)).round(ROUNDING_PRECISION));
    }

    @Override
    public Page<TextWithNumberReportDataDTO> ordersByServicemanInMonth(final Integer month, final Integer year, Pageable pageable) {
        Page<AccessLevel> accessLevels = accessLevelReportsRepository.findAllByAccessLevelName(Roles.SERVICEMAN, pageable);
        return new PageImpl<>(accessLevels.get()
                .map(accessLevel -> new TextWithNumberReportDataDTO(
                        accessLevel.getAccount().getUsername(),
                        BigDecimal.valueOf(orderReportsRepository.findOrdersByServicemanInMonth(month, year, accessLevel.getId()))
                                .round(ROUNDING_PRECISION)))
                .toList(),
                accessLevels.getPageable(),
                accessLevels.getTotalElements());
    }

    @Override
    public OrdersReportInfoDTO getOrders(final Integer month, final Integer year) {
        return new OrdersReportInfoDTO(
                BigDecimal.valueOf(
                        Optional.ofNullable(adminReportsRepository.findByMonthYearOrderStatus(month, year, OrderStatus.OPEN)
                                .getValue()).orElse(0L)
                ).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(
                                Optional.ofNullable(adminReportsRepository.findByMonthYearOrderStatus(month, year, OrderStatus.IN_PROGRESS)
                                        .getValue()).orElse(0L))
                        .round(ROUNDING_PRECISION),
                BigDecimal.valueOf(
                                Optional.ofNullable(adminReportsRepository.findByMonthYearOrderStatus(month, year, OrderStatus.FOR_SETTLEMENT)
                                        .getValue()).orElse(0L))
                        .round(ROUNDING_PRECISION),
                BigDecimal.valueOf(
                                Optional.ofNullable(adminReportsRepository.findByMonthYearOrderStatus(month, year, OrderStatus.CLOSED)
                                        .getValue()).orElse(0L))
                        .round(ROUNDING_PRECISION),
                BigDecimal.valueOf(
                                Optional.ofNullable(adminReportsRepository.findByDelayed(month, year)
                                        .getValue()).orElse(0L))
                        .round(ROUNDING_PRECISION)
        );
    }
}
