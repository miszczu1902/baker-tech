package pl.lodz.p.it.bakertech.accounts.dto.accounts.account;

import pl.lodz.p.it.bakertech.validation.constraint.accounts.City;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.PostalCode;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Street;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.StreetNumber;

public record AddressDTO(
        @Street String street,
        @StreetNumber String streetNumber,
        @City String city,
        @PostalCode String postalCode) {
}
