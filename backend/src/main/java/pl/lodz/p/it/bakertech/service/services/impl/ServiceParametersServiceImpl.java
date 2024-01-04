package pl.lodz.p.it.bakertech.service.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameter;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.service.dto.parameters.ModifyServiceParameterDTO;
import pl.lodz.p.it.bakertech.service.dto.parameters.ServiceParameterDTO;
import pl.lodz.p.it.bakertech.service.repositories.ServiceParametersRepository;
import pl.lodz.p.it.bakertech.service.services.ServiceParametersService;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.utils.mappers.service.ServiceParametersMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
@PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
public class ServiceParametersServiceImpl extends CommonService implements ServiceParametersService {
    private final ServiceParametersRepository serviceParametersRepository;
    private final ServiceParametersMapper serviceParametersMapper;

    @Autowired
    public ServiceParametersServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                        Keycloak keycloak,
                                        KeycloakMapper keycloakMapper,
                                        ETagGenerator eTagGenerator,
                                        ServiceParametersRepository serviceParametersRepository,
                                        ServiceParametersMapper serviceParametersMapper) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.serviceParametersRepository = serviceParametersRepository;
        this.serviceParametersMapper = serviceParametersMapper;
    }

    @Override
    public Set<ServiceParameterDTO> getServiceParameters() {
        return serviceParametersRepository.findAll()
                .stream()
                .map(serviceParametersMapper::serviceParametrersToServiceParametersDTO)
                .collect(Collectors.toSet());

    }

    @Override
    public ServiceParameterDTO getServiceParameter(final ServiceParameterType parameterType) {
        return serviceParametersMapper.serviceParametrersToServiceParametersDTO(serviceParametersRepository
                .findByServiceParameterType(parameterType).orElseThrow());
    }

    @Override
    public void updateServiceParameter(final ModifyServiceParameterDTO serviceParameters, final String ifMatch) {
        ServiceParameter serviceParameterData = serviceParametersRepository
                .findByServiceParameterType(serviceParameters.serviceParameterType())
                .orElseThrow();
        if (ifMatch.equals(eTagGenerator.generateETagValue(serviceParameterData))) {
            serviceParameterData.setValue(serviceParameters.value());
            serviceParametersRepository.saveAndFlush(serviceParameterData);
        } else {
            throw AppException.createContentWasChangedException();
        }
    }
}