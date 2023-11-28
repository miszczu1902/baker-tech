package pl.lodz.p.it.bakertech.model.service.orders;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "orders", indexes = {
        @Index(name = "client_account_id", columnList = "client_id"),
        @Index(name = "serviceman_account_id", columnList = "serviceman_id"),
        @Index(name = "order_data_id", columnList = "order_data_id")
})
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(discriminatorType = DiscriminatorType.STRING, name = "order_type")
public abstract class Order extends AbstractEntity {
    @ManyToOne
    @JoinColumn(name = "serviceman_id", referencedColumnName = "id")
    private Serviceman serviceman;

    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false, updatable = false, referencedColumnName = "id")
    private Client client;

    @OneToOne
    @JoinColumn(name = "order_data_id", referencedColumnName = "id")
    private OrderData orderData;

    @Column(name = "order_type", updatable = false, nullable = false, insertable = false)
    private String orderType;

    @Column(name = "date_of_order_execution", nullable = false)
    private LocalDate dateOfOrderExecution;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private OrderStatus status;

    @Column(name = "delayed", updatable = false, nullable = false, columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean delayed;
}