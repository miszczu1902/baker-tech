package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.security.Roles;

@Getter
@Setter
@Entity
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@DiscriminatorValue(Roles.ADMINISTRATOR)
@Table(name = "administrator")
public class Administrator extends AccessLevel {
    public Administrator(Account account) {
        super(account);
    }
}