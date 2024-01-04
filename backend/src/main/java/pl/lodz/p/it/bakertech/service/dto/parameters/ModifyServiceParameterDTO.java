package pl.lodz.p.it.bakertech.service.dto.parameters;

import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.validation.constraint.parameters.ServiceParameterValue;

import java.math.BigDecimal;

public record ModifyServiceParameterDTO(ServiceParameterType serviceParameterType,
                                        @ServiceParameterValue BigDecimal value) {
}
