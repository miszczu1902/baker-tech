package pl.lodz.p.it.bakertech.accounts.dto.accounts.account;

import pl.lodz.p.it.bakertech.validation.constraint.accounts.NIP;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.REGON;

public record BillingDetailsDTO(
        @NIP String nip,
        @REGON String regon
) {
}
