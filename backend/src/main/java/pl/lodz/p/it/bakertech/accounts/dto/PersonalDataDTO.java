package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.Firstname;
import pl.lodz.p.it.bakertech.validation.constraint.Lastname;
import pl.lodz.p.it.bakertech.validation.constraint.PhoneNumber;

public record PersonalDataDTO(
        @Firstname String firstname,
        @Lastname String lastname,
        @PhoneNumber String phoneNumber
) {
}
