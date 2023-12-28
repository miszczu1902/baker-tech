package pl.lodz.p.it.bakertech.utils.mappers;

import org.mapstruct.*;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.AccountDataListDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.*;
import pl.lodz.p.it.bakertech.accounts.dto.register.client.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.PersonalData;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Administrator;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Address;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.BillingDetails;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;

import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
public interface AccountAndAccessLevelMapper {
    @Mappings({
            @Mapping(target = "isActive", expression = "java(false)"),
            @Mapping(target = "personalData", expression = "java(personalDataDTOToPersonalDataEntity(registerAccount.getPersonalData()))")
    })
    Account registerAccountDTOToAccountEntity(RegisterAccountDTO registerAccount);

    @Mappings({
            @Mapping(target = "billingDetails", expression = "java(billingDetailsDTOToBillingDetailsEntity(registerClient.getBillingDetails()))"),
            @Mapping(target = "address", expression = "java(addressDTOToAddressEntity(registerClient.getAddress()))"),
    })
    Client registerAccountDTOToClientEntity(RegisterClientDTO registerClient);

    Serviceman registerAccountDTOToServicemanEntity(RegisterAccountDTO registerAccount);

    Administrator registerAccountDTOToAdministratorEntity(RegisterAccountDTO registerAccount);

    PersonalData personalDataDTOToPersonalDataEntity(PersonalDataDTO personalData);

    BillingDetails billingDetailsDTOToBillingDetailsEntity(BillingDetailsDTO billingDetails);

    Address addressDTOToAddressEntity(AddressDTO address);

    AccountDataListDTO accountEntityToAccountListDataDTO(Account account);

    @Mappings({
            @Mapping(target = "personalData", expression = "java(personalDataEntityEntityToPersonalDataDTOFromAccount(account))"),
            @Mapping(target = "address", expression = "java(addressEntityToAddressDTOFromAccount(account))"),
            @Mapping(target = "billingDetails", expression = "java(billingDetailsEntityToBillingDetailsDTOFromAccount(account))"),
            @Mapping(target = "accessLevels", expression = "java(accountEntityToAccessLevelsDTO(account))"),
            @Mapping(target = "licenseId", expression = "java(getServicemanLicenseIdForAccount(account))"),
    })
    AccountDataDTO accountEntityToAccountDataDTO(Account account);

    @Mappings({
            @Mapping(target = "id", source = "account.id"),
            @Mapping(target = "username", source = "account.username"),
            @Mapping(target = "email", source = "account.email"),
            @Mapping(target = "isActive", source = "account.isActive")
    })
    AccountDataListDTO accessLevelEntityToAccountDataDTO(AccessLevel accessLevel);

    PersonalDataDTO personalDataEntityEntityToPersonalDataDTO(PersonalData personalData);

    default Set<String> accountEntityToAccessLevelsDTO(Account account) {
        return account.getAccessLevels()
                .stream()
                .map(AccessLevel::getAccessLevelName)
                .collect(Collectors.toSet());
    }

    default String getServicemanLicenseIdForAccount(Account account) {
        return account.getAccessLevels()
                .stream()
                .filter(accessLevel -> accessLevel instanceof Serviceman)
                .map(accessLevel -> ((Serviceman) accessLevel).getLicenseId().toString())
                .findFirst()
                .orElse(null);
    }

    default PersonalDataDTO personalDataEntityEntityToPersonalDataDTOFromAccount(Account account) {
        return account.getAccessLevels()
                .stream()
                .map(accessLevel -> personalDataEntityEntityToPersonalDataDTO(account.getPersonalData()))
                .findFirst().orElse(null);
    }

    BillingDetailsDTO billingDetailsEntityToBillingDetailsDTO(BillingDetails billingDetails);

    default BillingDetailsDTO billingDetailsEntityToBillingDetailsDTOFromAccount(Account account) {
        return account.getAccessLevels()
                .stream()
                .filter(accessLevel -> accessLevel instanceof Client)
                .findAny()
                .map(accessLevel -> billingDetailsEntityToBillingDetailsDTO(((Client) accessLevel).getBillingDetails()))
                .orElse(null);
    }

    AddressDTO addressEntityToAddressDTO(Address address);

    default AddressDTO addressEntityToAddressDTOFromAccount(Account account) {
        return account.getAccessLevels()
                .stream()
                .filter(accessLevel -> accessLevel instanceof Client)
                .findAny()
                .map(accessLevel -> addressEntityToAddressDTO(((Client) accessLevel).getAddress()))
                .orElse(null);
    }

    default Account accountEntityFromRegisterAccountDTO(RegisterAccountDTO registerAccount) {
        final Account account = registerAccountDTOToAccountEntity(registerAccount);
        var accessLevel = registerAccount instanceof RegisterClientDTO
                ? registerAccountDTOToClientEntity((RegisterClientDTO) registerAccount)
                : registerAccountDTOToServicemanEntity(registerAccount);
        accessLevel.setAccount(account);
        account.getAccessLevels().add(accessLevel);
        return account;
    }
}