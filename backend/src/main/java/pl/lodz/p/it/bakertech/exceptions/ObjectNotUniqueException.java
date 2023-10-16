package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class ObjectNotUniqueException extends AppException {
    public ObjectNotUniqueException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}