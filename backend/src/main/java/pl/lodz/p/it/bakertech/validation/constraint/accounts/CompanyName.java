package pl.lodz.p.it.bakertech.validation.constraint.accounts;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidCompanyName;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@NotNull
@Size(min = 2, max = 64)
public @interface CompanyName {
    String message() default invalidCompanyName;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
