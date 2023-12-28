package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.reports.Report;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
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
public abstract class AccessLevel extends AbstractEntityWithId {
    @ManyToOne
    @JoinColumn(name = "account_id", updatable = false, nullable = false, referencedColumnName = "id")
    private Account account;

    @OneToMany(mappedBy = "accessLevel")
    private Set<Report> reports;

    @Column(name = "access_level_name", updatable = false, nullable = false, insertable = false)
    private String accessLevelName;

    public AccessLevel(Account account) {
        this.account = account;
    }
}