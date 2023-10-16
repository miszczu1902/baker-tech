package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class KeycloakException extends AppException {
    public KeycloakException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
