package pl.lodz.p.it.bakertech.service.exceptions;

import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.Messages;

public class CannotAssignNonWarrantyDeviceToWarrantyRepairException extends AppException {
    public CannotAssignNonWarrantyDeviceToWarrantyRepairException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }

    public static CannotAssignNonWarrantyDeviceToWarrantyRepairException createException() {
        return new CannotAssignNonWarrantyDeviceToWarrantyRepairException(HttpStatus.BAD_REQUEST, Messages.cannotAssignNonWarrantyDevice, new RuntimeException());
    }
}
