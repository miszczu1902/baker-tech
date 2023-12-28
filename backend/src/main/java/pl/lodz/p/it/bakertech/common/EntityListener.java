package pl.lodz.p.it.bakertech.common;

import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import pl.lodz.p.it.bakertech.accounts.repositories.AccountForEntityListenerRepository;
import pl.lodz.p.it.bakertech.model.AbstractEntity;

import java.time.LocalDateTime;
import java.util.Optional;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.TIMEZONE;

@Component
@NoArgsConstructor
public class EntityListener {
    private ApplicationContext applicationContext;

    @Autowired
    public EntityListener(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
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
