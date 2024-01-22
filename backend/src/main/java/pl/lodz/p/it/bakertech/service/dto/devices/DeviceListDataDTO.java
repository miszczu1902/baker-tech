package pl.lodz.p.it.bakertech.service.dto.devices;

import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

public record DeviceListDataDTO(
        Long id,
        @ETagField Long version,
        @ETagField String deviceName,
        @ETagField String brand,
        @ETagField String serialNumber,
        @ETagField Boolean warrantyEnded,
        DeviceCategory category
) {
}
