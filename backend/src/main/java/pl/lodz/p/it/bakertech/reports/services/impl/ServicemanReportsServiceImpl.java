package pl.lodz.p.it.bakertech.reports.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import pl.lodz.p.it.bakertech.reports.dto.TextWithNumberReportDataDTO;
import pl.lodz.p.it.bakertech.reports.dto.NumberValueDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;
import pl.lodz.p.it.bakertech.reports.repositories.AccessLevelReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.OrderReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.DeviceReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.ServicemanReportsRepository;
import pl.lodz.p.it.bakertech.reports.services.ServicemanReportsService;
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
@PreAuthorize("hasRole(@Roles.SERVICEMAN)")
public class ServicemanReportsServiceImpl extends CommonService implements ServicemanReportsService {
    private final ServicemanReportsRepository servicemanReportsRepository;
    private final OrderReportsRepository orderReportsRepository;
    private final AccessLevelReportsRepository accessLevelReportsRepository;
    private final DeviceReportsRepository deviceReportsRepository;

    @Autowired
    public ServicemanReportsServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                        Keycloak keycloak,
                                        KeycloakMapper keycloakMapper,
                                        ETagGenerator eTagGenerator,
                                        ServicemanReportsRepository servicemanReportsRepository,
                                        OrderReportsRepository orderReportsRepository,
                                        AccessLevelReportsRepository accessLevelReportsRepository,
                                        DeviceReportsRepository deviceReportsRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.servicemanReportsRepository = servicemanReportsRepository;
        this.orderReportsRepository = orderReportsRepository;
        this.accessLevelReportsRepository = accessLevelReportsRepository;
        this.deviceReportsRepository = deviceReportsRepository;
    }

    @Override
    public NumberValueDTO getAverageOrderTimeExecution(Integer month, Integer year) {
        String currentServicemanUsername = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getName();
        return new NumberValueDTO(BigDecimal.valueOf(
                        Optional.ofNullable(servicemanReportsRepository
                                .getAverageOrderTimeExecutionForServiceman(month, year, currentServicemanUsername)).orElse(0D))
                .round(ROUNDING_PRECISION));
    }

    @Override
    public TextWithNumberReportDataDTO getAmountOfOrdersExecutedByServiceman(Integer month, Integer year) {
        String currentServicemanUsername = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getName();
        Long id = accessLevelReportsRepository.findByAccount_UsernameAndAccessLevelNameEquals(currentServicemanUsername, Roles.SERVICEMAN)
                .orElseThrow().getId();
        return new TextWithNumberReportDataDTO(currentServicemanUsername, BigDecimal.valueOf(
                        Optional.ofNullable(orderReportsRepository.findOrdersByServicemanInMonth(month, year, id)).orElse(0L))
                .round(ROUNDING_PRECISION));
    }

    @Override
    public TextWithNumberReportDataDTO getTheMostFrequentlyRepairedTypeOfDevicesInService(Integer month, Integer year) {
        var result = deviceReportsRepository.getTheMostFrequentlyRepairedTypeOfDevices(month, year);
        return new TextWithNumberReportDataDTO(result.getCategory().toString(),
                BigDecimal.valueOf(
                                Optional.ofNullable(result.getValue()).orElse(0L))
                        .round(ROUNDING_PRECISION)
        );
    }

    @Override
    public PercentageOfOrdersDTO findPercentageOfOrdersByTypeAndUsername(Integer month, Integer year) {
        String currentServicemanUsername = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getName();
        var result = servicemanReportsRepository.findPercentageOfOrdersByTypeAndUsernameWithDefault(month, year, currentServicemanUsername);
        return new PercentageOfOrdersDTO(
                BigDecimal.valueOf(Optional.ofNullable(result.getNonWarrantyRepair()).orElse(0D)).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(Optional.ofNullable(result.getWarrantyRepair()).orElse(0D)).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(Optional.ofNullable(result.getConservation()).orElse(0D)).round(ROUNDING_PRECISION));
    }
}
