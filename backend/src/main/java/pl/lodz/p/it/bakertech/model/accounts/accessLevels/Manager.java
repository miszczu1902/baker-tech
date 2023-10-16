package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.security.Roles;

@Getter
@EqualsAndHashCode(callSuper = true)
@Entity
@DiscriminatorValue(Roles.MANAGER)
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class Manager extends AccessLevel {
}
