package pl.lodz.p.it.bakertech.model;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.common.EntityListener;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@MappedSuperclass
@EntityListeners(EntityListener.class)
public abstract class AbstractEntity {
    @ETagField
    @Version
    private Long version;

    @Column(name = "creation_date_time", nullable = false, updatable = false)
    private LocalDateTime creationDateTime;

    @OneToOne
    @JoinColumn(name = "created_by", updatable = false)
    private Account createdBy;

    @Column(name = "last_modification_date_time")
    private LocalDateTime lastModificationDateTime;

    @OneToOne
    @JoinColumn(name = "last_modification_by")
    private Account lastModificationBy;
}
