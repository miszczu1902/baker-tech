package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.*;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

@Getter
@Setter
@Entity
@AllArgsConstructor
@Table(name = "non_warranty_repair")
@DiscriminatorValue("NON_WARRANTY_REPAIR")
public class NonWarrantyRepair extends Order {
}