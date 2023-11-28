package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.model.accounts.ServiceLanguage;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.*;

public record RegisterClientDTO(
        @Username String username,
        @Password String password,
        @Email String email,
        @CompanyName String companyName,
        @Language ServiceLanguage language,
        AddressDTO address,
        BillingDetailsDTO billingDetails,
        PersonalDataDTO personalData
) {
}
