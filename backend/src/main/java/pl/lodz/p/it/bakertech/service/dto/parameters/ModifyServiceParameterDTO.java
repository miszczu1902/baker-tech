package pl.lodz.p.it.bakertech.service.dto.parameters;

import pl.lodz.p.it.bakertech.validation.constraint.parameters.ServiceParameterValue;

import java.math.BigDecimal;

public record ModifyServiceParameterDTO(@ServiceParameterValue BigDecimal value) {
}
