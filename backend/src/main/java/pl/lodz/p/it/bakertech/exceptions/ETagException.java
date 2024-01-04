package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class ETagException extends AppException {
    public ETagException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
