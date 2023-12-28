package pl.lodz.p.it.bakertech.exceptions;

import jakarta.ws.rs.BadRequestException;
import jakarta.ws.rs.ForbiddenException;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.lodz.p.it.bakertech.accounts.excpetions.*;
import pl.lodz.p.it.bakertech.validation.Messages;

@Getter
public class AppException extends ResponseStatusException {
    private final Throwable cause;

    public AppException(HttpStatus status, String reason, Throwable cause) {
        super(status, reason);
        this.cause = cause;
    }

    public static AppException createAppException(final Throwable cause) {
        return new AppException(HttpStatus.INTERNAL_SERVER_ERROR, Messages.internalServerError, cause);
    }

    public static AppException createForbiddenException(final Throwable cause) {
        return new AppException(HttpStatus.FORBIDDEN, Messages.errorForbidden, cause);
    }

    public static AppException createOptimisticLockException(final Throwable cause) {
        return new OptimisticLockException(HttpStatus.INTERNAL_SERVER_ERROR, Messages.internalServerError, cause);
    }

    public static AppException createPersistenceException(final Throwable cause) {
        return new PersistenceException(HttpStatus.INTERNAL_SERVER_ERROR, Messages.internalServerError, cause);
    }

    public static AppException createEntityNotFoundException(final Throwable cause) {
        return new ObjectNotFoundException(HttpStatus.NOT_FOUND, Messages.objectNotFound, cause);
    }

    public static AppException createEntityExistsException(final Throwable cause) {
        return new ObjectNotUniqueException(HttpStatus.CONFLICT, Messages.objectNotUnique, cause);
    }

    public static AppException createValidationException(final Throwable cause) {
        return createValidationException(cause, null);
    }

    public static AppException createValidationException(final Throwable cause, String message) {
        return new ValidationException(HttpStatus.BAD_REQUEST, message != null ? message : Messages.validationViolation, cause);
    }

    public static AppException createKeycloakException() {
        return createKeycloakException(new RuntimeException());
    }

    public static AppException createKeycloakException(final Throwable cause) {
        return new KeycloakException(HttpStatus.INTERNAL_SERVER_ERROR, Messages.internalServerError, cause);
    }

    public static AppException createRegistrationException() {
        return createRegistrationException(new RuntimeException());
    }

    public static AppException createRegistrationException(final Throwable cause) {
        return new RegistrationException(HttpStatus.INTERNAL_SERVER_ERROR, Messages.internalServerError, cause);
    }

    public static AppException createCannotChangeStatusForSelfAccountException() {
        return new CannotChangeStatusForSelfAccountException(HttpStatus.FORBIDDEN, Messages.cannotChangeStatusSelf, new ForbiddenException());
    }

    public static AppException createCannotChangeAccessLevelSelfException() {
        return new CannotChangeAccessLevelSelfException(HttpStatus.FORBIDDEN, Messages.cannotChangeAccessLevelsSelf, new ForbiddenException());
    }

    public static AppException createCannotAssignAccessLevelsException() {
        return new CannotAssignAccessLevelsException(HttpStatus.FORBIDDEN, Messages.cannotAssignAccessLevels, new ForbiddenException());
    }

    public static AppException createCannotRemoveOnlyOneAssignedAccessLevelToAccountException() {
        return new CannotRemoveOnlyOneAssignedAccessLevelToAccountException(HttpStatus.FORBIDDEN, Messages.cannotRemoveOneAccessLevel, new BadRequestException());
    }
}
