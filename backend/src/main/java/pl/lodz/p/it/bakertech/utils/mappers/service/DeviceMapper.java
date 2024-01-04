package pl.lodz.p.it.bakertech.utils.mappers.service;

import org.mapstruct.Mapper;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.service.dto.devices.AddDeviceDTO;
import pl.lodz.p.it.bakertech.service.dto.devices.DeviceListDataDTO;

@Mapper(componentModel = "spring")
public interface DeviceMapper {
    DeviceListDataDTO deviceEntityToDeviceListData(Device device);

    Device addDeviceToDeviceEntity(AddDeviceDTO device);
}
