package pl.lodz.p.it.bakertech.interceptors;

import jakarta.persistence.PersistenceException;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.annotation.Order;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import java.util.NoSuchElementException;

@Slf4j
@Aspect
@Order(1)
@Component
public class ServiceExceptionInterceptor implements CommonInterceptor {
    @Override
    @Pointcut("@within(pl.lodz.p.it.bakertech.interceptors.Interception)")
    public void intercept() {
    }

    @AfterThrowing(pointcut = "intercept()", throwing = "ex")
    public void catchException(Throwable ex) {
        try {
            throw ex;
        } catch (NoSuchElementException nsee) {
            throw AppException.createEntityNotFoundException(nsee);
        } catch (DataAccessException dae) {
            switch (dae) {
                case DataIntegrityViolationException dive -> {
                    if (dive.getMessage().contains("unique")) {
                        throw AppException.createEntityExistsException(dae.getCause());
                    } else {
                        throw AppException.createValidationException(dae.getCause());
                    }
                }
                case EmptyResultDataAccessException erdae -> throw AppException.createEntityNotFoundException(erdae.getCause());
                case OptimisticLockingFailureException ole -> throw AppException.createOptimisticLockException(ole.getCause());
                default -> throw AppException.createValidationException(dae.getCause());
            }
        } catch (PersistenceException | java.sql.SQLException pe) {
            throw AppException.createPersistenceException(pe);
        } catch (AppException ae) {
            throw ae;
        } catch (Throwable e) {
            throw AppException.createAppException(e.getCause());
        }
    }
}
