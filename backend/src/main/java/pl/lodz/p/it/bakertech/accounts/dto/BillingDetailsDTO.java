package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.NIP;
import pl.lodz.p.it.bakertech.validation.constraint.REGON;

public record BillingDetailsDTO(
        @NIP String nip,
        @REGON String regon
) {
}
