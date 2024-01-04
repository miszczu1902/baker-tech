package pl.lodz.p.it.bakertech.utils.mappers.reports;

import org.mapstruct.Mapper;
import pl.lodz.p.it.bakertech.reports.dto.client.ClientDeviceReportInfoDTO;
import pl.lodz.p.it.bakertech.reports.repositories.projections.ServicedDevicesProjection;

@Mapper(componentModel = "spring")
public interface ProjectionMapper {
    ClientDeviceReportInfoDTO deviceProjectionToDeviceReportInfo(ServicedDevicesProjection projection);
}
