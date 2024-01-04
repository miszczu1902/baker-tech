package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

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

    @ETagField
    @Column(name ="report_next_automatically", nullable = false)
    private Boolean reportNextAutomatically;
}