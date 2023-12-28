package pl.lodz.p.it.bakertech.accounts.dto.register.client;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AddressDTO;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.BillingDetailsDTO;
import pl.lodz.p.it.bakertech.accounts.dto.register.RegisterAccountDTO;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@ToString(exclude = "password")
public class RegisterClientDTO extends RegisterAccountDTO {
    @CompanyName
    private String companyName;

    @Password
    @NotNull
    private String password;

    private AddressDTO address;

    private BillingDetailsDTO billingDetails;
}