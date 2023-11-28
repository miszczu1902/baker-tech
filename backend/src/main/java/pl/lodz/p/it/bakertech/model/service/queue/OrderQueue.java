package pl.lodz.p.it.bakertech.model.service.queue;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "order_queue")
public class OrderQueue extends AbstractEntity {
    @OneToMany
    @JoinColumn(name = "orders", referencedColumnName = "id", nullable = false)
    private List<Order> orders = new ArrayList<>();
}