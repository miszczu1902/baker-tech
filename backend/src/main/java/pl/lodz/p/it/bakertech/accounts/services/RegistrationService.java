package pl.lodz.p.it.bakertech.accounts.services;

import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;

public interface RegistrationService {
    String registerAccount(RegisterAccountDTO client);

    void confirmAccountRegistration(String confirmationToken);
}
