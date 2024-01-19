package pl.lodz.p.it.bakertech.reports.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.reports.dto.NumberValueDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;
import pl.lodz.p.it.bakertech.reports.dto.client.ClientDeviceReportInfoDTO;
import pl.lodz.p.it.bakertech.reports.repositories.ClientReportsRepository;
import pl.lodz.p.it.bakertech.reports.repositories.DeviceReportsRepository;
import pl.lodz.p.it.bakertech.reports.services.ClientReportsService;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.utils.mappers.reports.ProjectionMapper;
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
@PreAuthorize("hasRole(@Roles.CLIENT)")
public class ClientReportsServiceImpl extends CommonService implements ClientReportsService {
    private final ClientReportsRepository clientReportsRepository;
    private final DeviceReportsRepository deviceReportsRepository;
    private final ProjectionMapper projectionMapper;

    @Autowired
    public ClientReportsServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                    Keycloak keycloak,
                                    KeycloakMapper keycloakMapper,
                                    ETagGenerator eTagGenerator,
                                    ClientReportsRepository clientReportsRepository,
                                    DeviceReportsRepository deviceReportsRepository,
                                    ProjectionMapper projectionMapper) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.clientReportsRepository = clientReportsRepository;
        this.deviceReportsRepository = deviceReportsRepository;
        this.projectionMapper = projectionMapper;
    }

    @Override
    public NumberValueDTO getDevicesUnderWarrantyByMonth(final Integer month, final Integer year) {
        return new NumberValueDTO(BigDecimal.valueOf(clientReportsRepository.countDevicesUnderWarrantyByMonth(
                        month, year, SecurityContextHolder.getContext().getAuthentication().getName()))
                .round(ROUNDING_PRECISION));
    }

    @Override
    public NumberValueDTO getOrdersInMonthForClient(final Integer month, final Integer year) {
        return new NumberValueDTO(BigDecimal.valueOf(clientReportsRepository.countOrdersForClientByUsernameAndMonth(
                        month, year, SecurityContextHolder.getContext().getAuthentication().getName()))
                .round(ROUNDING_PRECISION));
    }

    @Override
    public Page<ClientDeviceReportInfoDTO> getServicedDevicesForClient(final Integer month, final Integer year, Pageable pageable) {
        var result = deviceReportsRepository.getDevicesServicedForClient(month, year, SecurityContextHolder.getContext().getAuthentication().getName(), pageable);
        return new PageImpl<>(
                result.get()
                        .map(projectionMapper::deviceProjectionToDeviceReportInfo)
                        .toList(),
                result.getPageable(),
                result.getTotalElements()
        );
    }

    @Override
    public PercentageOfOrdersDTO findPercentageOfOrdersByTypeAndUsername(Integer month, Integer year) {
        var result = clientReportsRepository.findPercentageOfOrdersByTypeAndUsernameWithDefault(
                month,
                year,
                SecurityContextHolder.getContext()
                        .getAuthentication()
                        .getName());
        return new PercentageOfOrdersDTO(
                BigDecimal.valueOf(Optional.ofNullable(result.getNonWarrantyRepair()).orElse(0D)).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(Optional.ofNullable(result.getWarrantyRepair()).orElse(0D)).round(ROUNDING_PRECISION),
                BigDecimal.valueOf(Optional.ofNullable(result.getConservation()).orElse(0D)).round(ROUNDING_PRECISION));
    }
}
