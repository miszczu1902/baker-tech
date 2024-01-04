package pl.lodz.p.it.bakertech.model.service.parameters;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "service_parameters",
        indexes = {@Index(name = "service_parameter_type_name", columnList = "service_parameter_type", unique = true)
})
public class ServiceParameter extends AbstractEntityWithId {
    @Enumerated(EnumType.STRING)
    @Column(name = "service_parameter_type", nullable = false)
    private ServiceParameterType serviceParameterType;

    @ETagField
    @Column(name = "value", nullable = false)
    private BigDecimal value;
}