package pl.lodz.p.it.bakertech.model;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.common.EntityListener;
import pl.lodz.p.it.bakertech.model.accounts.Account;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@MappedSuperclass
@EntityListeners(EntityListener.class)
public abstract class AbstractEntity {

    @Version
    private Long version;

    @Setter
    @Column(name = "creation_date_time", nullable = false, updatable = false)
    private LocalDateTime creationDateTime;

    @Setter
    @OneToOne
    @JoinColumn(name = "created_by", updatable = false)
    private Account createdBy;

    @Setter
    @Column(name = "last_modification_date_time")
    private LocalDateTime lastModificationDateTime;

    @Setter
    @OneToOne
    @JoinColumn(name = "last_modification_by")
    private Account lastModificationBy;
}
