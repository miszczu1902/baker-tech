package pl.lodz.p.it.bakertech.validation.constraint;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static pl.lodz.p.it.bakertech.validation.Messages.invalidPhoneNumber;

@Constraint(validatedBy = {})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@ReportAsSingleViolation
@NotNull
@Pattern(regexp = "^(?:\\+\\d{1,3}\\s?)?(?:\\d{3,4})?\\d{6,10}$")
public @interface PhoneNumber {
    String message() default invalidPhoneNumber;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
