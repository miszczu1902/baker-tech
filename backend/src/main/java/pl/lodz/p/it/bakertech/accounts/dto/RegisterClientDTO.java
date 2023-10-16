package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.*;

public record RegisterClientDTO(
        @Username String username,
        @Password String password,
        @Email String email,
        @ClientName String clientName,
        @Language String language,
        AddressDTO address,
        BillingDetailsDTO billingDetails,
        PersonalDataDTO personalData
) {
}
