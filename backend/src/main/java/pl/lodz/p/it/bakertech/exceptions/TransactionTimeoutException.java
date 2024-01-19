package pl.lodz.p.it.bakertech.exceptions;

import org.springframework.http.HttpStatus;

public class TransactionTimeoutException extends AppException {
    public TransactionTimeoutException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason, cause);
    }
}
