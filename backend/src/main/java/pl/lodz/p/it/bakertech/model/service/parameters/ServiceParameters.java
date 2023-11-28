package pl.lodz.p.it.bakertech.model.service.parameters;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.parameters.CutOffDatePeriod;
import pl.lodz.p.it.bakertech.validation.constraint.parameters.UnitCostOfWorkingHour;

import java.math.BigDecimal;

@Data
@Entity
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Table(name = "service_parameters")
public class ServiceParameters extends AbstractEntity {
    @UnitCostOfWorkingHour
    @Column(name ="unit_cost_of_working_hour", nullable = false)
    private BigDecimal unitCostOfWorkingHour;

    @CutOffDatePeriod
    @Column(name ="cut_off_date_period", nullable = false)
    private Long cutOffDatePeriod;

    public ServiceParameters(BigDecimal unitCostOfWorkingHour, Long cutOffDatePeriod) {
        this.unitCostOfWorkingHour = unitCostOfWorkingHour;
        this.cutOffDatePeriod = cutOffDatePeriod;
    }
}