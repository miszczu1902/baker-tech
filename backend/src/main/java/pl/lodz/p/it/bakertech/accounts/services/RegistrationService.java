package pl.lodz.p.it.bakertech.accounts.services;

import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.ConfirmAccountDTO;

public interface RegistrationService {
    String registerAccount(RegisterAccountDTO client);

    void confirmAccountRegistration(ConfirmAccountDTO confirmAccount);
}
