package pl.lodz.p.it.bakertech.model.accounts.accessLevels.client;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.City;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.PostalCode;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Street;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.StreetNumber;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "address")
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