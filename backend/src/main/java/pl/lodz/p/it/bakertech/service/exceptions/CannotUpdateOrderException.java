package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotUpdateOrderException extends AppException {
    public CannotUpdateOrderException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotUpdateOrderException createException() {
        return new CannotUpdateOrderException(HttpStatus.BAD_REQUEST, Messages.cannotChangeOrder, new RuntimeException());
    }
}
