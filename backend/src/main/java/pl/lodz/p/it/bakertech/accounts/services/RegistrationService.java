package pl.lodz.p.it.bakertech.accounts.services;

import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;

public interface RegistrationService {
    Long registerAccount(RegisterAccountDTO client);

    void confirmAccountRegistration(String confirmationToken);
}
