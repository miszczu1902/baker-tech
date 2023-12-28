package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;

public class CannotAssignAccessLevelsException extends AppException {
    public CannotAssignAccessLevelsException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
