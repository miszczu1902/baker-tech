package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotSettleOrderByYourselfException extends AppException {
    public CannotSettleOrderByYourselfException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotUpdateOrderException createExcpetion() {
        return new CannotUpdateOrderException(HttpStatus.FORBIDDEN, Messages.cannotSettleOrder, new RuntimeException());
    }
}
