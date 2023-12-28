package pl.lodz.p.it.bakertech.model.accounts.accessLevels.client;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.accounts.Account;
import pl.lodz.p.it.bakertech.model.accounts.PersonalData;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.CompanyName;

import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "client",
        indexes = {
                @Index(name = "address_id", columnList = "address_id"),
                @Index(name = "billing_details_id", columnList = "billing_details_id")
        })
@DiscriminatorValue(Roles.CLIENT)
public class Client extends AccessLevel {
    @CompanyName
    @Column(name = "company_name", unique = true, nullable = false)
    private String companyName;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id", nullable = false, referencedColumnName = "id")
    private Address address;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "billing_details_id", nullable = false, referencedColumnName = "id")
    private BillingDetails billingDetails;

    @OneToMany(mappedBy = "client")
    private Set<Order> orders = new HashSet<>();

    public Client(Account account, String companyName, Address address, BillingDetails billingDetails) {
        super(account);
        this.companyName = companyName;
        this.address = address;
        this.billingDetails = billingDetails;
    }
}