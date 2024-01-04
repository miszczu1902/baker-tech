package pl.lodz.p.it.bakertech.service.dto.devices;

import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.Brand;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.DeviceName;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.SerialNumber;

public record AddDeviceDTO(
        @DeviceName String deviceName,
        @Brand String brand,
        @SerialNumber String serialNumber,
        Boolean warrantyEnded,
        DeviceCategory category
) {
}
