package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class ObjectNotFoundException extends AppException {
    public ObjectNotFoundException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
