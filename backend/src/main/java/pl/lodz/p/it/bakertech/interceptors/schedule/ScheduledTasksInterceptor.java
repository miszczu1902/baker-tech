package pl.lodz.p.it.bakertech.interceptors.schedule;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.interceptors.CommonInterceptor;
import pl.lodz.p.it.bakertech.security.Roles;

@Slf4j
@Aspect
@Order(0)
@Component
public class ScheduledTasksInterceptor implements CommonInterceptor {
    @Override
    @Pointcut("@within(pl.lodz.p.it.bakertech.interceptors.schedule.ScheduledInterception)")
    public void intercept() {
    }

    @Before("intercept()")
    public void beforeScheduledMethod() {
        final AnonymousAuthenticationToken token = new AnonymousAuthenticationToken(
                "system",
                "system",
                AuthorityUtils.createAuthorityList("ROLE_%s".formatted(Roles.SYSTEM))
        );
        SecurityContextHolder.getContext().setAuthentication(token);
    }

    @After("intercept()")
    public void afterScheduledMethod() {
        SecurityContextHolder.clearContext();
    }
}
