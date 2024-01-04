package pl.lodz.p.it.bakertech.service.dto.devices;

import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

public record DeviceListDataDTO(
        Long id,
        @ETagField Long version,
        String deviceName,
        String brand,
        String serialNumber,
        @ETagField Boolean warrantyEnded,
        DeviceCategory category
) {
}
