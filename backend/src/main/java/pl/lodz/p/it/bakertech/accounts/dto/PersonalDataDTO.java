package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.accounts.Firstname;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Lastname;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.PhoneNumber;

public record PersonalDataDTO(
        @Firstname String firstname,
        @Lastname String lastname,
        @PhoneNumber String phoneNumber
) {
}
