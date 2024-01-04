package pl.lodz.p.it.bakertech.model.service.orders;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "orders", indexes = {
        @Index(name = "client_account_id", columnList = "client_id"),
        @Index(name = "serviceman_account_id", columnList = "serviceman_id"),
        @Index(name = "order_data_id", columnList = "order_data_id")
}, uniqueConstraints = {
        @UniqueConstraint(
                name = "order_for_client_in_time_exists", columnNames = {"client_id", "order_type", "date_of_order_execution", "status"})
})
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(discriminatorType = DiscriminatorType.STRING, name = "order_type")
public abstract class Order extends AbstractEntityWithId {
    @ManyToOne
    @JoinColumn(name = "serviceman_id", referencedColumnName = "id")
    private Serviceman serviceman;

    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false, updatable = false, referencedColumnName = "id")
    private Client client;

    @OneToOne(cascade = {CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.REMOVE})
    @JoinColumn(name = "order_data_id", referencedColumnName = "id")
    private OrderData orderData;

    @Enumerated(EnumType.STRING)
    @Column(name = "order_type", updatable = false, nullable = false, insertable = false)
    private OrderType orderType;

    @Column(name = "date_of_order_execution", nullable = false)
    private LocalDateTime dateOfOrderExecution;

    @ETagField
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, columnDefinition = "public.order_status")
    private OrderStatus status;

    @Column(name = "delayed", nullable = false, columnDefinition = "boolean default false")
    private Boolean delayed;

    @Column(name = "in_order_queue", nullable = false, columnDefinition = "boolean default true")
    private Boolean inOrderQueue;
}