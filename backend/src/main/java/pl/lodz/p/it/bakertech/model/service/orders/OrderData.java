package pl.lodz.p.it.bakertech.model.service.orders;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.validation.constraint.orders.Description;
import pl.lodz.p.it.bakertech.validation.constraint.orders.OrderDuration;
import pl.lodz.p.it.bakertech.validation.constraint.orders.TotalCost;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "order_data")
public class OrderData extends AbstractEntity {
    @OrderDuration
    @Column(name = "duration", nullable = false)
    private BigDecimal duration;

    @TotalCost
    @Column(name = "total_cost" , nullable = false)
    private BigDecimal totalCost;

    @OneToMany
    @JoinColumn(name = "devices", referencedColumnName = "id")
    private Set<Device> device = new HashSet<>();

    @Description
    @Column(name = "description", updatable = false)
    private String description;
}
