package pl.lodz.p.it.bakertech.validation.constraint.service;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.Positive;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidOrderDuration;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@Positive
public @interface OrderDuration {
    String message() default invalidOrderDuration;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
