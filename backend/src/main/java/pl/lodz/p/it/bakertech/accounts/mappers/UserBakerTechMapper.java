package pl.lodz.p.it.bakertech.accounts.mappers;

import pl.lodz.p.it.bakertech.accounts.dto.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterServicemanDTO;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.PersonalData;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Address;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.BillingDetails;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;

public class UserBakerTechMapper {
    public static Account registerClientDTOToAccountEntity(RegisterClientDTO registerClientDTO) {
        Account account = new Account(
                registerClientDTO.username(),
                registerClientDTO.email(),
                registerClientDTO.language()
        );
        Client client = new Client(
                account,
                new PersonalData(
                        registerClientDTO.personalData().firstname(),
                        registerClientDTO.personalData().lastname(),
                        registerClientDTO.personalData().phoneNumber()
                ),
                true,
                registerClientDTO.companyName(),
                new Address(
                        registerClientDTO.address().street(),
                        registerClientDTO.address().streetNumber(),
                        registerClientDTO.address().city(),
                        registerClientDTO.address().postalCode()
                ),
                new BillingDetails(
                        registerClientDTO.billingDetails().nip(),
                        registerClientDTO.billingDetails().regon()
                )
        );

        account.getAccessLevels().add(client);
        return account;
    }

    public static Account registerServicemanDTOToAccountEntity(RegisterServicemanDTO registerServicemanDTO) {
        Account account = new Account(
                registerServicemanDTO.username(),
                registerServicemanDTO.email(),
                registerServicemanDTO.language()
        );
        Serviceman serviceman = new Serviceman(
                account,
                new PersonalData(
                        registerServicemanDTO.personalData().firstname(),
                        registerServicemanDTO.personalData().lastname(),
                        registerServicemanDTO.personalData().phoneNumber()
                ),
                true
        );

        account.getAccessLevels().add(serviceman);
        return account;
    }
}
