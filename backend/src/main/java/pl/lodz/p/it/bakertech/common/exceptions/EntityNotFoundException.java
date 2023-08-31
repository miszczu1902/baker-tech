package pl.lodz.p.it.bakertech.common.exceptions;

import org.springframework.http.HttpStatus;

public class EntityNotFoundException extends AppException {
    public EntityNotFoundException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
