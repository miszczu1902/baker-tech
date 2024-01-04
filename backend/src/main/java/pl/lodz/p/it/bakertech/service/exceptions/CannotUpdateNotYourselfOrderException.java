package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotUpdateNotYourselfOrderException extends AppException {
    public CannotUpdateNotYourselfOrderException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotUpdateNotYourselfOrderException createExcpetion() {
        return new CannotUpdateNotYourselfOrderException(HttpStatus.FORBIDDEN, Messages.cannotChangeOrderNotSelf, new RuntimeException());
    }
}
