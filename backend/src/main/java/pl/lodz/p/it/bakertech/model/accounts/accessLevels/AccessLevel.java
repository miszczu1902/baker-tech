package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.PersonalData;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "access_level",
        indexes = {
                @Index(name = "access_level_account_id", columnList = "account_id")
        },
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "access_level_unique_constraint", columnNames = {"account_id", "access_level_name"})
        })
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(discriminatorType = DiscriminatorType.STRING, name = "access_level_name")
public abstract class AccessLevel extends AbstractEntity {
    @Setter
    @ManyToOne
    @JoinColumn(name = "account_id", updatable = false, nullable = false, referencedColumnName = "id")
    private Account account;

    @Column(name = "access_level_name", updatable = false, nullable = false, insertable = false)
    private String accessLevelName;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "personal_data", nullable = false)
    private PersonalData personalData;

    @Column(name = "isActive", nullable = false, columnDefinition = "VARCHAR DEFAULT TRUE")
    private boolean isActive;

    public AccessLevel(Account account, PersonalData personalData, boolean isActive) {
        this.account = account;
        this.personalData = personalData;
        this.isActive = isActive;
    }
}
