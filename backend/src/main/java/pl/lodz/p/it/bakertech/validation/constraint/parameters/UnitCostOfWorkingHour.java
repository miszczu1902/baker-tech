package pl.lodz.p.it.bakertech.validation.constraint.parameters;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.Positive;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidUnitCostOfWorkingHour;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@Positive
public @interface UnitCostOfWorkingHour {
    String message() default invalidUnitCostOfWorkingHour;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
