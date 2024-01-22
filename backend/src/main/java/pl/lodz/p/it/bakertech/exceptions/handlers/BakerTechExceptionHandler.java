package pl.lodz.p.it.bakertech.exceptions.handlers;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.exceptions.dto.ErrorResponseDTO;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.validation.Messages;

@Slf4j
@ControllerAdvice
public class BakerTechExceptionHandler extends ResponseEntityExceptionHandler {
    private String getMessageDependsOnStatusCode(HttpStatusCode statusCode) {
        switch (statusCode.value()) {
            case 401 -> {
                return Messages.errorUnauthorized;
            }
            case 403 -> {
                return Messages.errorForbidden;
            }
            default -> {
                return Messages.badRequest;
            }
        }
    }

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex,
                                                             Object body,
                                                             HttpHeaders headers,
                                                             HttpStatusCode statusCode,
                                                             WebRequest request) {
        if (ex instanceof AppException) {
            return this.handleAppException((AppException) ex);
        }
        String message = (ex instanceof MethodArgumentNotValidException)
                ? Messages.validationViolation
                : this.getMessageDependsOnStatusCode(statusCode);
        return this.handleAppException(new AppException(statusCode, message, ex.getCause()));
    }

    @ExceptionHandler(value = AppException.class)
    protected ResponseEntity<Object> handleAppException(final AppException ex) {
        String title = HttpStatus.valueOf(ex.getStatusCode().value())
                .getReasonPhrase()
                .replace(" ", "_")
                .toUpperCase();
        String timestamp = DateUtility.nowWithTimestamp().toString();

        return new ResponseEntity<>(new ErrorResponseDTO(
                title,
                ex.getStatusCode().value(),
                ex.getReason(),
                timestamp), ex.getStatusCode());
    }
}