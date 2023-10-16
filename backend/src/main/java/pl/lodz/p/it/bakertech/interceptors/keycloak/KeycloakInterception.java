package pl.lodz.p.it.bakertech.interceptors.keycloak;

import java.lang.annotation.*;

@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface KeycloakInterception {
}
