package pl.lodz.p.it.bakertech.model.accounts.accessLevels.client;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.City;
import pl.lodz.p.it.bakertech.validation.constraint.PostalCode;
import pl.lodz.p.it.bakertech.validation.constraint.Street;
import pl.lodz.p.it.bakertech.validation.constraint.StreetNumber;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
public class Address extends AbstractEntity {
    @Street
    @Column(name = "street", nullable = false)
    private String street;

    @StreetNumber
    @Column(name = "building_number", nullable = false)
    private String streetNumber;

    @City
    @Column(name = "city", nullable = false)
    private String city;

    @PostalCode
    @Column(name = "postal_code", nullable = false)
    private String postalCode;
}