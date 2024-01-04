package pl.lodz.p.it.bakertech.accounts.excpetions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class RegistrationException extends AppException {
    public RegistrationException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static RegistrationException createRegistrationException() {
        return createRegistrationException(new RuntimeException());
    }

    public static RegistrationException createRegistrationException(final Throwable cause) {
        return new RegistrationException(HttpStatus.INTERNAL_SERVER_ERROR, Messages.internalServerError, cause);
    }
}

