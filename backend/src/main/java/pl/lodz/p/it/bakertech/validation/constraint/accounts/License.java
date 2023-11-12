package pl.lodz.p.it.bakertech.validation.constraint.accounts;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.Min;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidLicense;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@Min(value = 100000000000000L)
@Min(value = 999999999999999L)
public @interface License {
    String message() default invalidLicense;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
