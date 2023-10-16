package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.*;
import pl.lodz.p.it.bakertech.security.Roles;

@Entity
@Getter
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@DiscriminatorValue(Roles.ADMINISTRATOR)
public class Administrator extends AccessLevel {
}
