package pl.lodz.p.it.bakertech.service.dto.parameters;

import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.math.BigDecimal;

public record ServiceParameterDTO(Long id,
                                  @ETagField Long version,
                                  ServiceParameterType serviceParameterType,
                                  @ETagField BigDecimal value) {
}
