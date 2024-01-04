package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotRemoveOnlyOneAssignedAccessLevelToAccountException extends AppException {
    public CannotRemoveOnlyOneAssignedAccessLevelToAccountException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotRemoveOnlyOneAssignedAccessLevelToAccountException createException() {
        return new CannotRemoveOnlyOneAssignedAccessLevelToAccountException(HttpStatus.FORBIDDEN, Messages.cannotRemoveOneAccessLevel, new RuntimeException());
    }
}
