package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

@Entity
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Table(name = "non_warranty_repair")
@DiscriminatorValue("NON_WARRANTY_REPAIR")
public class NonWarrantyRepair extends Order {
}