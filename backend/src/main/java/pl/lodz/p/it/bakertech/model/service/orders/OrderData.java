package pl.lodz.p.it.bakertech.model.service.orders;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.validation.constraint.service.Description;
import pl.lodz.p.it.bakertech.validation.constraint.service.OrderDuration;
import pl.lodz.p.it.bakertech.validation.constraint.service.TotalCost;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

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
    @ETagField
    @OrderDuration
    @Column(name = "duration")
    private BigDecimal duration;

    @ETagField
    @TotalCost
    @Column(name = "total_cost")
    private BigDecimal totalCost;

    @ManyToMany
    @JoinTable(
            name = "device_order_data",
            joinColumns = @JoinColumn(name = "device_id"),
            inverseJoinColumns = @JoinColumn(name = "order_data_id")
    )
    private Set<Device> devices = new HashSet<>();

    @Description
    @Column(name = "description", updatable = false)
    private String description;
}
