package pl.lodz.p.it.bakertech.accounts.dto.register;

import pl.lodz.p.it.bakertech.validation.constraint.accounts.ConfirmationToken;

public record ConfirmAccountDTO(@ConfirmationToken String confirmationToken) {
}
