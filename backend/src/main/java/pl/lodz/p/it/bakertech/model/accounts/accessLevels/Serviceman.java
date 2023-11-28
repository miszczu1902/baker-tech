package pl.lodz.p.it.bakertech.model.accounts.accessLevels;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.PersonalData;
import pl.lodz.p.it.bakertech.security.Roles;

@Entity
@Table(name = "serviceman",
        indexes = {
                @Index(name = "unique_license_id", columnList = "license_id", unique = true)
        })
@DiscriminatorValue(Roles.SERVICEMAN)
@EqualsAndHashCode(callSuper = true)
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

    public Serviceman(Account account, PersonalData personalData, boolean isActive) {
        super(account, personalData, isActive);
    }
}