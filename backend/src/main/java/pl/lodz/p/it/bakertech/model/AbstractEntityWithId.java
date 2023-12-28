package pl.lodz.p.it.bakertech.model;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.model.accounts.Account;

import java.time.LocalDateTime;
import java.util.Objects;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@MappedSuperclass
public abstract class AbstractEntityWithId extends AbstractEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AbstractEntityWithId that = (AbstractEntityWithId) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    public AbstractEntityWithId(Long version,
                                LocalDateTime creationDateTime,
                                Account createdBy,
                                LocalDateTime lastModificationDateTime,
                                Account lastModificationBy,
                                Long id) {
        super(version, creationDateTime, createdBy, lastModificationDateTime, lastModificationBy);
        this.id = id;
    }
}
