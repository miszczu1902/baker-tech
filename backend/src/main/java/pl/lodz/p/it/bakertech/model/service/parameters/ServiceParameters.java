package pl.lodz.p.it.bakertech.model.service.parameters;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.validation.constraint.parameters.CutOffDatePeriod;
import pl.lodz.p.it.bakertech.validation.constraint.parameters.UnitCostOfWorkingHour;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "service_parameters")
public class ServiceParameters extends AbstractEntityWithId {
    @UnitCostOfWorkingHour
    @Column(name = "unit_cost_of_working_hour", nullable = false)
    private BigDecimal unitCostOfWorkingHour;

    @CutOffDatePeriod
    @Column(name = "cut_off_date_period", nullable = false)
    private Long cutOffDatePeriod;

    public ServiceParameters(BigDecimal unitCostOfWorkingHour, Long cutOffDatePeriod) {
        this.unitCostOfWorkingHour = unitCostOfWorkingHour;
        this.cutOffDatePeriod = cutOffDatePeriod;
    }
}