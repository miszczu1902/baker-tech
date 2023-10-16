package pl.lodz.p.it.bakertech.interceptors;

import java.lang.annotation.*;

@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE})
public @interface Interception {
}
