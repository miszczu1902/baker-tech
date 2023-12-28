package pl.lodz.p.it.bakertech.model.service.queue;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "order_queue")
public class OrderQueue extends AbstractEntityWithId {
    @OneToMany
    @JoinColumn(name = "orders", referencedColumnName = "id", nullable = false)
    private List<Order> orders = new ArrayList<>();
}