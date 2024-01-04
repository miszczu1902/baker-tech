package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class IncorrectDatePeriodForOrderException extends AppException {
    public IncorrectDatePeriodForOrderException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static IncorrectDatePeriodForOrderException createException() {
        return new IncorrectDatePeriodForOrderException(HttpStatus.BAD_REQUEST, Messages.invalidDatePeriod, new RuntimeException());
    }
}
