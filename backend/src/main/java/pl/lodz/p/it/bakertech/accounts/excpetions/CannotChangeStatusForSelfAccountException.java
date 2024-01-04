package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotChangeStatusForSelfAccountException extends AppException {
    public CannotChangeStatusForSelfAccountException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotChangeStatusForSelfAccountException createException() {
        return new CannotChangeStatusForSelfAccountException(HttpStatus.FORBIDDEN, Messages.cannotChangeStatusSelf, new RuntimeException());
    }
}
