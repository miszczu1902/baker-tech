package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

import java.time.LocalDate;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Table(name = "warranty_repair")
@DiscriminatorValue("WARRANTY_REPAIR")
public class WarrantyRepair extends Order {
    @Column(name = "last_date_of_device_service")
    private LocalDate lastDateOfDeviceService;
}