package pl.lodz.p.it.bakertech.validation.constraint.service;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import pl.lodz.p.it.bakertech.validation.Messages;
import pl.lodz.p.it.bakertech.validation.validator.OrderValidator;

import java.lang.annotation.*;

@Constraint(validatedBy = OrderValidator.class)
@Documented
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@ReportAsSingleViolation
public @interface Order {
    String message() default Messages.invalidDatePeriod;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
