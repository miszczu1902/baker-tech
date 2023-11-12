package pl.lodz.p.it.bakertech.interceptors.keycloak;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import jakarta.ws.rs.ProcessingException;

@Slf4j
@Aspect
@Order(0)
@Component
@RequiredArgsConstructor
public class KeycloakInterceptor {
    @AfterThrowing(
            pointcut = "@within(pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception)",
            throwing = "ex"
    )
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
