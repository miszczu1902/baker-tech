package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class OptimisticLockException extends AppException {
    public OptimisticLockException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
