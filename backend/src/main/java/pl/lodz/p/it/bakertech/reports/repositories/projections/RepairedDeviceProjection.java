package pl.lodz.p.it.bakertech.reports.repositories.projections;

import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;

public interface RepairedDeviceProjection {
    DeviceCategory getCategory();

    Long getValue();
}
