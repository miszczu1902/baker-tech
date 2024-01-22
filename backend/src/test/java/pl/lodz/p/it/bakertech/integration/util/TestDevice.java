package pl.lodz.p.it.bakertech.integration.util;

import lombok.Builder;
import lombok.Data;
import lombok.experimental.Accessors;
import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.service.dto.devices.AddDeviceDTO;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

@Data
@Builder
@Accessors(fluent = true)
public class TestDevice {
    private Long id;
    private DeviceCategory category;

    @ETagField
    private String deviceName;

    @ETagField
    private String brand;

    @ETagField
    private String serialNumber;

    @ETagField
    private Long version;

    @ETagField
    private Boolean warrantyEnded;

    public static TestDevice MEGA_BAKERS = builder()
            .id(-6L)
            .version(0L)
            .deviceName("MegaBakers")
            .brand("Bread Slicer")
            .serialNumber("MGBS1122")
            .category(DeviceCategory.MECHANICAL)
            .warrantyEnded(false)
            .build();

    public static TestDevice SUPERIOR_BAKE = builder()
            .id(-8L)
            .version(0L)
            .deviceName("SuperiorBake")
            .brand("Pastry Sheeter'")
            .serialNumber("SBPS4455")
            .category(DeviceCategory.ELECTROMECHANICAL)
            .warrantyEnded(false)
            .build();

    public static AddDeviceDTO DEVICE_TO_ADD = new AddDeviceDTO(
            "New Device",
            "New Device",
            "1223243255",
            false,
            DeviceCategory.MECHANICAL);
}
