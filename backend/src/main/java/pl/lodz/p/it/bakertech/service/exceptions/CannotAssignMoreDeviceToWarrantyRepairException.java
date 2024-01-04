package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotAssignMoreDeviceToWarrantyRepairException extends AppException {
    public CannotAssignMoreDeviceToWarrantyRepairException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotAssignMoreDeviceToWarrantyRepairException createException() {
        return new CannotAssignMoreDeviceToWarrantyRepairException(HttpStatus.BAD_REQUEST, Messages.cannotAssignMoreWarrantyDevice, new RuntimeException());
    }
}
