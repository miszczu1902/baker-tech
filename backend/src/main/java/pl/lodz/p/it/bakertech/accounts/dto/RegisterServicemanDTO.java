package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.accounts.Email;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Language;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Password;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Username;

public record RegisterServicemanDTO(
        @Username String username,
        @Password String password,
        @Email String email,
        @Language String language,
        PersonalDataDTO personalData
) {
}
