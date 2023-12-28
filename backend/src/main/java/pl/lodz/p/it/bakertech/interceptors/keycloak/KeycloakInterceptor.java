package pl.lodz.p.it.bakertech.interceptors.keycloak;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import jakarta.ws.rs.ProcessingException;
import pl.lodz.p.it.bakertech.interceptors.CommonInterceptor;

@Slf4j
@Aspect
@Order(0)
@Component
public class KeycloakInterceptor implements CommonInterceptor {
    @Override
    @Pointcut("@within(pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception)")
    public void intercept() {
    }

    @AfterThrowing(pointcut = "intercept()", throwing = "ex")
    public void catchException(Throwable ex) {
        try {
            throw ex;
        } catch (ProcessingException pe) {
            throw AppException.createKeycloakException(pe);
        } catch (AppException ae) {
            throw ae;
        } catch (Throwable e) {
            throw AppException.createKeycloakException(e.getCause());
        }
    }
}
