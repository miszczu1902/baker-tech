package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.City;
import pl.lodz.p.it.bakertech.validation.constraint.PostalCode;
import pl.lodz.p.it.bakertech.validation.constraint.Street;
import pl.lodz.p.it.bakertech.validation.constraint.StreetNumber;

public record AddressDTO(
        @Street String street,
        @StreetNumber String streetNumber,
        @City String city,
        @PostalCode String postalCode) {
}
