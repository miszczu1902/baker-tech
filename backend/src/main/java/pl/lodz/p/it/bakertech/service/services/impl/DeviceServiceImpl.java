package pl.lodz.p.it.bakertech.service.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.exceptions.ForbiddenException;
import pl.lodz.p.it.bakertech.exceptions.TransactionTimeoutException;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.service.dto.devices.AddDeviceDTO;
import pl.lodz.p.it.bakertech.service.dto.devices.DeviceListDataDTO;
import pl.lodz.p.it.bakertech.service.exceptions.WarrantyAlreadyEndedException;
import pl.lodz.p.it.bakertech.service.repositories.AccessLevelServiceRepository;
import pl.lodz.p.it.bakertech.service.repositories.DeviceRepository;
import pl.lodz.p.it.bakertech.service.repositories.OrderRepository;
import pl.lodz.p.it.bakertech.service.services.DeviceService;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.utils.mappers.service.DeviceMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.util.Collections;

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
public class DeviceServiceImpl extends CommonService implements DeviceService {
    private final DeviceRepository deviceRepository;
    private final OrderRepository orderRepository;
    private final AccessLevelServiceRepository accessLevelRepository;
    private final DeviceMapper deviceMapper;

    @Autowired
    public DeviceServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                             Keycloak keycloak,
                             KeycloakMapper keycloakMapper,
                             ETagGenerator eTagGenerator,
                             DeviceRepository deviceRepository,
                             OrderRepository orderRepository,
                             AccessLevelServiceRepository accessLevelRepository,
                             DeviceMapper deviceMapper) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.deviceRepository = deviceRepository;
        this.orderRepository = orderRepository;
        this.accessLevelRepository = accessLevelRepository;
        this.deviceMapper = deviceMapper;
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public Page<DeviceListDataDTO> getDevices(String serialNumber, Boolean warrantyEnded, DeviceCategory category, Pageable pageable) {
        Page<Device> devices = deviceRepository
                .findAllBySerialNumberAndWarrantyAndCategory(serialNumber, warrantyEnded, category, pageable);
        return new PageImpl<>(devices.get()
                .map(deviceMapper::deviceEntityToDeviceListData)
                .toList(),
                devices.getPageable(),
                devices.getTotalElements());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public Page<DeviceListDataDTO> getDevicesForOrder(Long orderId, Pageable pageable) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        return orderRepository.findById(orderId)
                .map(order -> {
                    if (accessLevelRepository.existsByAccessLevelNameAndAccount_Username(Roles.CLIENT, username)
                            && !order.getClient().getAccount().getUsername().equals(username)) {
                        throw ForbiddenException.createException();
                    } else {
                        Page<Device> devices = deviceRepository.findAllByOrdersContaining(order.getOrderData(), pageable);
                        return new PageImpl<>(devices
                                .map(deviceMapper::deviceEntityToDeviceListData)
                                .toList(),
                                devices.getPageable(),
                                devices.getTotalElements());
                    }

                }).orElse(new PageImpl<>(Collections.emptyList(), Pageable.unpaged(), 0));
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public DeviceListDataDTO getDevice(final Long id) {
        return deviceMapper.deviceEntityToDeviceListData(deviceRepository.findById(id).orElseThrow());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public void addDeviceToService(final AddDeviceDTO deviceToAdd) {
        deviceRepository.saveAndFlush(deviceMapper.addDeviceToDeviceEntity(deviceToAdd));
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public void markEndedWarrantyForDevice(final Long deviceId, final String ifMatch) {
        Device device = deviceRepository.findById(deviceId).orElseThrow();
        if (ifMatch.equals(eTagGenerator.generateETagValue(device))) {
            if (device.getWarrantyEnded()) {
                throw WarrantyAlreadyEndedException.createException();
            }
            device.setWarrantyEnded(true);
            deviceRepository.saveAndFlush(device);
        } else {
            throw AppException.createOptimisticLockException();
        }
    }
}
