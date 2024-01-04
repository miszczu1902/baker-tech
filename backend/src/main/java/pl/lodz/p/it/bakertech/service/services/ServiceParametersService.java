package pl.lodz.p.it.bakertech.service.services;

import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.service.dto.parameters.ModifyServiceParameterDTO;
import pl.lodz.p.it.bakertech.service.dto.parameters.ServiceParameterDTO;

import java.util.Set;

public interface ServiceParametersService {
    Set<ServiceParameterDTO> getServiceParameters();

    ServiceParameterDTO getServiceParameter(ServiceParameterType parameterType);

    void updateServiceParameter(ModifyServiceParameterDTO serviceParameters, String ifMatch);
}
