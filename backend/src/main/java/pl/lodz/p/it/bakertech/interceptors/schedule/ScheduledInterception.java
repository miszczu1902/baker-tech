package pl.lodz.p.it.bakertech.interceptors.schedule;

import java.lang.annotation.*;

@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface ScheduledInterception {
}
