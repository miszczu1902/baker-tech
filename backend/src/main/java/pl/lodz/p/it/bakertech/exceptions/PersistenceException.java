package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class PersistenceException extends AppException {
    public PersistenceException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
