package pl.lodz.p.it.bakertech.common.exceptions.handlers;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import pl.lodz.p.it.bakertech.common.exceptions.AppException;
import pl.lodz.p.it.bakertech.common.exceptions.dto.ErrorResponseDTO;
import pl.lodz.p.it.bakertech.config.BakerTechConfig;

import java.time.LocalDateTime;

@Slf4j
@ControllerAdvice
public class BakerTechExceptionHandler extends ResponseEntityExceptionHandler {
    @ExceptionHandler(value = AppException.class)
    public ResponseEntity<ErrorResponseDTO> AppExceptionHandler(AppException ex) {
        String title = HttpStatus.valueOf(ex.getStatusCode().value()).getReasonPhrase().replace(" ", "_").toUpperCase();
        String timestamp = LocalDateTime.now().format(BakerTechConfig.DATE_TIME_FORMATTER);

        return new ResponseEntity<>(new ErrorResponseDTO(title, ex.getStatusCode().value(), ex.getReason(), timestamp), ex.getStatusCode());
    }
}
