package pl.lodz.p.it.bakertech.validation.constraint.service;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidOrderDescription;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@Length(max = 2000)
@NotNull
public @interface Description {
    String message() default invalidOrderDescription;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
