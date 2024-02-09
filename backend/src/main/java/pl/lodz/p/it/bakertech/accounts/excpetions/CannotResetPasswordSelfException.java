package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotResetPasswordSelfException extends AppException {
    public CannotResetPasswordSelfException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotResetPasswordSelfException createException() {
        return new CannotResetPasswordSelfException(HttpStatus.FORBIDDEN, Messages.cannotResetPassword, new RuntimeException());
    }
}
