package pl.lodz.p.it.bakertech.model.accounts.accessLevels.client;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.NIP;
import pl.lodz.p.it.bakertech.validation.constraint.REGON;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
public class BillingDetails extends AbstractEntity {
    @NIP
    @Column(name = "nip", updatable = false, unique = true, nullable = false)
    private String nip;

    @REGON
    @Column(name = "regon", updatable = false, unique = true, nullable = false)
    private String regon;
}
