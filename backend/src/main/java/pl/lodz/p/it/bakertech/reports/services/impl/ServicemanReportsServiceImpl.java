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
import pl.lodz.p.it.bakertech.reports.repositories.AccessLevelReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.OrderReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.DeviceReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.ServicemanReportsRepository;
import pl.lodz.p.it.bakertech.reports.services.ServicemanReportsService;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.math.BigDecimal;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.ROUNDING_PRECISION;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
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
        return new NumberValueDTO(BigDecimal.valueOf(servicemanReportsRepository
                .getAverageOrderTimeExecutionForServiceman(month, year, currentServicemanUsername)).round(ROUNDING_PRECISION));
    }

    @Override
    public TextWithNumberReportDataDTO getAmountOfOrdersExecutedByServiceman(Integer month, Integer year) {
        String currentServicemanUsername = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getName();
        Long id = accessLevelReportsRepository.findByAccount_Username(currentServicemanUsername).orElseThrow().getId();
        return new TextWithNumberReportDataDTO(currentServicemanUsername, BigDecimal.valueOf(orderReportsRepository.findOrdersByServicemanInMonth(month, year, id)).round(ROUNDING_PRECISION));
    }

    @Override
    public TextWithNumberReportDataDTO getTheMostFrequentlyRepairedTypeOfDevicesInService(Integer month, Integer year) {
        var result = deviceReportsRepository.getTheMostFrequentlyRepairedTypeOfDevices(month, year);
        return new TextWithNumberReportDataDTO(result.getCategory().toString(), BigDecimal.valueOf(result.getValue()).round(ROUNDING_PRECISION));
    }
}
