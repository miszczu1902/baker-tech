package pl.lodz.p.it.bakertech.model.accounts.accessLevels.client;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.PersonalData;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.validation.constraint.ClientName;

@Getter
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "client",
        indexes = {
                @Index(name = "address_id", columnList = "address_id"),
                @Index(name = "billing_details_id", columnList = "billing_details_id")
        })
@DiscriminatorValue(Roles.CLIENT)
public class Client extends AccessLevel {
    @ClientName
    @Column(name = "client_name", unique = true, nullable = false)
    private String clientName;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id", nullable = false, referencedColumnName = "id")
    private Address address;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "billing_details_id", nullable = false, referencedColumnName = "id")
    private BillingDetails billingDetails;

    public Client(Account account, PersonalData personalData, boolean isActive, String clientName, Address address, BillingDetails billingDetails) {
        super(account, personalData, isActive);
        this.clientName = clientName;
        this.address = address;
        this.billingDetails = billingDetails;
    }
}
