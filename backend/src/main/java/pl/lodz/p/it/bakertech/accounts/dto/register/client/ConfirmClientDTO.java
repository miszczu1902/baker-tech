package pl.lodz.p.it.bakertech.accounts.dto.register.client;

import pl.lodz.p.it.bakertech.validation.constraint.accounts.ConfirmationToken;

public record ConfirmClientDTO(@ConfirmationToken String confirmationToken) {
}
