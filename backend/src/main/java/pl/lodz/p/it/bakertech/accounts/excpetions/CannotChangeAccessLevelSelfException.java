package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;

public class CannotChangeAccessLevelSelfException extends AppException {
    public CannotChangeAccessLevelSelfException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
