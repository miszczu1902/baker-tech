package pl.lodz.p.it.bakertech.common.exceptions;

import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@Getter
public class AppException extends ResponseStatusException {
    private final Throwable cause;

    public AppException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason);
        this.cause = cause;
    }

    public static AppException createAppException(Throwable cause) {
        return new AppException(HttpStatus.INTERNAL_SERVER_ERROR, "Unknown error occurred", cause);
    }

    public static AppException createEntityNotFoundException(Throwable cause) {
        return new EntityNotFoundException(HttpStatus.NOT_FOUND, "Object not found", cause);
    }
}
