package pl.lodz.p.it.bakertech.common.interceptors;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Slf4j
@Aspect
@Component
public class LoggingInterceptor {
    private StringBuilder message;
    private Object result;

    @SuppressWarnings("unused")
    @Pointcut("@within(pl.lodz.p.it.bakertech.common.interceptors.Interception)")
    public void intercept() {
    }

    @Around("intercept()")
    public Object aroundInvoke(ProceedingJoinPoint joinPoint) throws Throwable {
        message = new StringBuilder("Intercepted method call: ");
        try {
            message.append(joinPoint.getSignature().toShortString()).append(" |");
            message.append(" user: ").append("TUTAJ_NARAZIE_NIE_MA_NIC").append(" |");
            message.append(" parameters values: ");
            for (Object param : joinPoint.getArgs()) {
                message.append(param).append(" ");
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

    @AfterThrowing(
            pointcut = "intercept()",
            throwing = "ex"
    )
    public void afterThrowing(Exception ex) {
        message.append(" thrown exception: ").append(ex);
        log.error(message.toString(), ex);
    }
}
