package pl.lodz.p.it.bakertech.common.interceptors;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.common.exceptions.AppException;

import java.util.NoSuchElementException;

@Slf4j
@Aspect
@Component
public class ServiceExceptionInterceptor {
    @AfterThrowing(
            pointcut = "@within(pl.lodz.p.it.bakertech.common.interceptors.Interception)",
            throwing = "ex"
    )
    public void catchException(Throwable ex) {
        try {
            throw ex;
        } catch (NoSuchElementException nsee) {
            throw AppException.createEntityNotFoundException(nsee);
        } catch (AppException ae) {
            throw ae;
        } catch (Throwable e) {
            throw AppException.createAppException(e.getCause());
        }
    }
}
