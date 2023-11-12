package pl.lodz.p.it.bakertech.validation.constraint.accounts;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidPostalCode;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@NotNull
@Pattern(regexp = "^\\d{2}-\\d{3}$")
@Size(min = 6, max = 6)
public @interface PostalCode {
    String message() default invalidPostalCode;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
