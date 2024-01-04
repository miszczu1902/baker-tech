package pl.lodz.p.it.bakertech.accounts.dto.accounts.account;

import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.util.Set;

public record AccountDataDTO(
        Long id,
        String username,
        String email,
        @ETagField Boolean isActive,
        PersonalDataDTO personalData,
        AddressDTO address,
        BillingDetailsDTO billingDetails,
        Set<String> accessLevels,
        String licenseId,
        @ETagField Long version
) {
}
