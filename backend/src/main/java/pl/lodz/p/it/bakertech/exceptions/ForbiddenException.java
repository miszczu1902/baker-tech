package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.validation.Messages;

public class ForbiddenException extends AppException {
    public ForbiddenException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static ForbiddenException createException() {
        return new ForbiddenException(HttpStatus.FORBIDDEN, Messages.errorForbidden, new RuntimeException());
    }
}
