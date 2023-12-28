package pl.lodz.p.it.bakertech.accounts.dto.accounts.account;

import java.util.Set;

public record AccountDataDTO(
        Long id,
        String username,
        String email,
        Boolean isActive,
        PersonalDataDTO personalData,
        AddressDTO address,
        BillingDetailsDTO billingDetails,
        Set<String> accessLevels,
        String licenseId,
        Long version
) {
}
