package pl.lodz.p.it.bakertech.utils.mappers.service;

import org.mapstruct.Mapper;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameter;
import pl.lodz.p.it.bakertech.service.dto.parameters.ServiceParameterDTO;

@Mapper(componentModel = "spring")
public interface ServiceParametersMapper {
    ServiceParameterDTO serviceParametrersToServiceParametersDTO(ServiceParameter serviceParameter);
}
