package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.security.Roles;

@Getter
@Setter
@Entity
@Table(name = "serviceman",
        indexes = {
                @Index(name = "unique_license_id", columnList = "license_id", unique = true)
        })
@DiscriminatorValue(Roles.SERVICEMAN)
@NoArgsConstructor(access = lombok.AccessLevel.PUBLIC)
public class Serviceman extends AccessLevel {
    @Column(
            name = "license_id",
            unique = true,
            nullable = false,
            insertable = false,
            updatable = false,
            columnDefinition = "bigint generated always as (generate_license_id()) stored not null"
    )
    private Long licenseId;

    public Serviceman(Account account) {
        super(account);
    }
}