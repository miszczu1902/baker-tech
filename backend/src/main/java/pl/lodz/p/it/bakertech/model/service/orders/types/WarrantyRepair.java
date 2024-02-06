package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "warranty_repair")
@DiscriminatorValue("WARRANTY_REPAIR")
public class WarrantyRepair extends Order {
    @Column(name = "last_date_of_device_service")
    private LocalDateTime lastDateOfDeviceService;
}