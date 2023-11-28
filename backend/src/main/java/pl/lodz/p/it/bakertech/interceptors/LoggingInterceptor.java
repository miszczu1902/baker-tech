package pl.lodz.p.it.bakertech.interceptors;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;

@Slf4j
@Aspect
@Component
public class LoggingInterceptor {
    private StringBuilder message;
    private Object result;

    @SuppressWarnings("unused")
    @Pointcut("@within(pl.lodz.p.it.bakertech.interceptors.Interception)")
    public void intercept() {
    }

    @Around("intercept()")
    public Object aroundInvoke(ProceedingJoinPoint joinPoint) throws Throwable {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();

        message = new StringBuilder("Intercepted method call: ");
        try {
            message.append(joinPoint.getSignature().toShortString()).append(" |");
            message.append(" user: ").append(username).append(" |");
            message.append(" parameters values: ");
            for (Object param : joinPoint.getArgs()) {
                if (param != null) {
                    Field[] fields = param.getClass().getDeclaredFields();
                    for (Field field : fields) {
                        field.setAccessible(true);
                        if (field.getName().equals("password")) {
                            message.append(field.getName()).append(": ***** *** ");
                        } else {
                            message.append(field.getName()).append(": ").append(field.get(param)).append(" ");
                        }
                    }
                } else {
                    message.append(" ");
                }
            }
            message.append("|");
        } catch (Exception e) {
            log.error("Unexpected exception in interceptor's code: ", e);
            throw e;
        }

        result = joinPoint.proceed();
        return result;
    }

    @AfterReturning("intercept()")
    public void afterInterception() {
        message.append(" returned value: ").append(result).append(" ");
        log.info(message.toString());
    }

    @AfterThrowing(pointcut = "intercept()", throwing = "ex")
    public void afterThrowing(Exception ex) {
        message.append(" thrown exception: ").append(ex);
        log.error(message.toString(), ex);
    }
}
