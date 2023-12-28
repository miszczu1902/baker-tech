package pl.lodz.p.it.bakertech.model.service.orders;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.validation.constraint.service.Description;
import pl.lodz.p.it.bakertech.validation.constraint.service.OrderDuration;
import pl.lodz.p.it.bakertech.validation.constraint.service.TotalCost;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "order_data")
public class OrderData extends AbstractEntityWithId {
    @OrderDuration
    @Column(name = "duration", nullable = false)
    private BigDecimal duration;

    @TotalCost
    @Column(name = "total_cost", nullable = false)
    private BigDecimal totalCost;

    @ManyToMany
    @JoinTable(
            name = "device_order_data",
            joinColumns = @JoinColumn(name = "device_id"),
            inverseJoinColumns = @JoinColumn(name = "order_data_id")
    )
    private Set<Device> device = new HashSet<>();

    @Description
    @Column(name = "description", updatable = false)
    private String description;
}
