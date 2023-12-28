package pl.lodz.p.it.bakertech.model.accounts.accessLevels.client;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.NIP;
import pl.lodz.p.it.bakertech.validation.constraint.accounts.REGON;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "billing_details")
public class BillingDetails extends AbstractEntityWithId {
    @NIP
    @Column(name = "nip", updatable = false, unique = true, nullable = false)
    private String nip;

    @REGON
    @Column(name = "regon", updatable = false, unique = true, nullable = false)
    private String regon;
}