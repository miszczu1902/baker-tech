package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "conservation")
@DiscriminatorValue("CONSERVATION")
public class Conservation extends Order {
    @Column(name = "date_of_next_device_conversation", nullable = false)
    private LocalDateTime dateOfNextDeviceConservation;

    @OneToOne
    @JoinColumn(name = "last_conservation_id", referencedColumnName = "id")
    private Conservation lastConservation;

    @Column(name ="report_next_automatically", nullable = false)
    private Boolean reportNextAutomatically;
}