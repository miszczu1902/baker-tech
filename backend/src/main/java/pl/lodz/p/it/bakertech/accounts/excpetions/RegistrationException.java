package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;

public class RegistrationException extends AppException {
    public RegistrationException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}

