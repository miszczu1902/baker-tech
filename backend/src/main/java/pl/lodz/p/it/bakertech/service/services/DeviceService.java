package pl.lodz.p.it.bakertech.service.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.service.dto.devices.AddDeviceDTO;
import pl.lodz.p.it.bakertech.service.dto.devices.DeviceListDataDTO;

public interface DeviceService {
    Page<DeviceListDataDTO> getDevices(String serialNumber, Boolean warrantyEnded, DeviceCategory category, Pageable pageable);

    Page<DeviceListDataDTO> getDevicesForOrder(Long orderId, Pageable pageable);

    DeviceListDataDTO getDevice(Long id);

    void addDeviceToService(AddDeviceDTO deviceToAdd);

    void markEndedWarrantyForDevice(Long deviceId, String ifMatch);
}
