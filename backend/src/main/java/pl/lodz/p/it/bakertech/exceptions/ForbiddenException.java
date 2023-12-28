package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class ForbiddenException extends AppException {
    public ForbiddenException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}