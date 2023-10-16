package pl.lodz.p.it.bakertech.accounts.dto;

import pl.lodz.p.it.bakertech.validation.constraint.*;

public record RegisterServicemanDTO(
        @Username String username,
        @Password String password,
        @Email String email,
        @Language String language,
        PersonalDataDTO personalData
) {
}
