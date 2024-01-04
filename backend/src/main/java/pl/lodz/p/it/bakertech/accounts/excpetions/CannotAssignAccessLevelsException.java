package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotAssignAccessLevelsException extends AppException {
    public CannotAssignAccessLevelsException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotAssignAccessLevelsException createException() {
        return new CannotAssignAccessLevelsException(HttpStatus.FORBIDDEN, Messages.cannotAssignAccessLevels, new RuntimeException());
    }
}
