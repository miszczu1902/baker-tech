package pl.lodz.p.it.bakertech.interceptors.keycloak;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.keycloak.admin.client.Keycloak;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.exceptions.AppException;

import javax.ws.rs.ProcessingException;

@Slf4j
@Aspect
@Order(0)
@Component
@RequiredArgsConstructor
public class KeycloakInterceptor {
    private final Keycloak keycloak;

    @AfterThrowing(
            pointcut = "@within(pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception)",
            throwing = "ex"
    )
    public void catchException(Throwable ex) {
        try {
            keycloak.close();
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
