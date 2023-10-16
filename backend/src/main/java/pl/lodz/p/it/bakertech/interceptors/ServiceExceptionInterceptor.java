package pl.lodz.p.it.bakertech.interceptors;

import jakarta.persistence.PersistenceException;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import java.util.NoSuchElementException;

@Slf4j
@Aspect
@Order(1)
@Component
public class ServiceExceptionInterceptor {
    @AfterThrowing(
            pointcut = "@within(pl.lodz.p.it.bakertech.interceptors.Interception)",
            throwing = "ex"
    )
    public void catchException(Throwable ex) {
        try {
            throw ex;
        } catch (NoSuchElementException nsee) {
            throw AppException.createEntityNotFoundException(nsee);
        } catch (DataIntegrityViolationException divo) {
            if (divo.getCause() instanceof org.hibernate.exception.ConstraintViolationException) {
                if (divo.getCause().getMessage().contains("unique")) {
                    throw AppException.createEntityExistsException(divo.getCause());
                }
            }
            throw AppException.createValidationException(divo.getCause());
        } catch (PersistenceException | java.sql.SQLException pe) {
            throw AppException.createPersistenceException(pe);
        } catch (AppException ae) {
            throw ae;
        } catch (Throwable e) {
            throw AppException.createAppException(e.getCause());
        }
    }
}
