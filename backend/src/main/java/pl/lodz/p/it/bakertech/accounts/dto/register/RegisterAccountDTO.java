package pl.lodz.p.it.bakertech.accounts.dto.register;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.PersonalDataDTO;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Email;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.Username;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class RegisterAccountDTO {
    @Username
    protected String username;

    @Email
    protected String email;

    protected String language;

    protected PersonalDataDTO personalData;
}
