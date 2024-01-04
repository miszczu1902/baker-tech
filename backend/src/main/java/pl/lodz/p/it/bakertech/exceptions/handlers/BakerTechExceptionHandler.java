package pl.lodz.p.it.bakertech.exceptions.handlers;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.exceptions.dto.ErrorResponseDTO;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.validation.Messages;

import java.util.Objects;
import java.util.Optional;

@Slf4j
@ControllerAdvice
public class BakerTechExceptionHandler extends ResponseEntityExceptionHandler {
    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        String title = HttpStatus.BAD_REQUEST.getReasonPhrase().replace(" ", "_").toUpperCase();
        String timestamp = DateUtility.nowWithTimestamp().toString();
        Optional<String> message = ex.getBindingResult()
                .getAllErrors()
                .stream()
                .map(ObjectError::getDefaultMessage)
                .filter(Objects::nonNull)
                .findFirst();

        return new ResponseEntity<>(new ErrorResponseDTO(
                title,
                HttpStatus.BAD_REQUEST.value(),
                message.orElse(Messages.validationViolation),
                timestamp), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(value = AccessDeniedException.class)
    public ResponseEntity<ErrorResponseDTO> AccessDeniedExceptionHandler(final AccessDeniedException ex) {
        String title = HttpStatus.FORBIDDEN.getReasonPhrase().replace(" ", "_").toUpperCase();
        String timestamp = DateUtility.nowWithTimestamp().toString();

        return new ResponseEntity<>(new ErrorResponseDTO(
                title,
                HttpStatus.FORBIDDEN.value(),
                Messages.errorForbidden,
                timestamp), HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(value = AppException.class)
    public ResponseEntity<ErrorResponseDTO> AppExceptionHandler(final AppException ex) {
        String title = HttpStatus.valueOf(ex.getStatusCode().value()).getReasonPhrase().replace(" ", "_").toUpperCase();
        String timestamp = DateUtility.nowWithTimestamp().toString();

        return new ResponseEntity<>(new ErrorResponseDTO(
                title,
                ex.getStatusCode().value(),
                ex.getReason(),
                timestamp), ex.getStatusCode());
    }
}
