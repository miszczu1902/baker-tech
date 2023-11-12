package pl.lodz.p.it.bakertech.validation.constraint.orders;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.Pattern;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidOrderDuration;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@Pattern(regexp = "[\\s]*[0-9]*[1-9]+")
public @interface OrderDuration {
    String message() default invalidOrderDuration;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
