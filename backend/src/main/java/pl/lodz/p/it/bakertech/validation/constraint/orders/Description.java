package pl.lodz.p.it.bakertech.validation.constraint.orders;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotEmpty;
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
@NotEmpty
public @interface Description {
    String message() default invalidOrderDescription;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
