package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class ContentWasChangedException extends AppException {
    public ContentWasChangedException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
