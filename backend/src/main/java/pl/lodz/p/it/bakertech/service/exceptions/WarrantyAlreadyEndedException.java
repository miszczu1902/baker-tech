package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class WarrantyAlreadyEndedException extends AppException {
    public WarrantyAlreadyEndedException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static WarrantyAlreadyEndedException createException() {
        return new WarrantyAlreadyEndedException(HttpStatus.CONFLICT, Messages.cannotChangeWarranty, new RuntimeException());
    }
}
