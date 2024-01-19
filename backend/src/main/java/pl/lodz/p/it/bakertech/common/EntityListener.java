package pl.lodz.p.it.bakertech.common;

import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountForEntityListenerRepository;
import pl.lodz.p.it.bakertech.model.AbstractEntity;

import java.time.LocalDateTime;
import java.util.Optional;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.TIMEZONE;

@Component
public class EntityListener implements ApplicationContextAware {
    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext context) {
        applicationContext = context;
    }

    @PrePersist
    public void initCreatedBy(AbstractEntity entity) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        AccountForEntityListenerRepository accountRepository = applicationContext.getBean(AccountForEntityListenerRepository.class);
        Optional.ofNullable(accountRepository.findAccountByUsername(username)).ifPresent(entity::setCreatedBy);
        entity.setCreationDateTime(LocalDateTime.now(TIMEZONE));
    }

    @PreUpdate
    public void initLastModifiedBy(AbstractEntity entity) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        AccountForEntityListenerRepository accountRepository = applicationContext.getBean(AccountForEntityListenerRepository.class);
        Optional.ofNullable(accountRepository.findAccountByUsername(username)).ifPresent(entity::setLastModificationBy);
        entity.setLastModificationDateTime(LocalDateTime.now(TIMEZONE));
    }
}
