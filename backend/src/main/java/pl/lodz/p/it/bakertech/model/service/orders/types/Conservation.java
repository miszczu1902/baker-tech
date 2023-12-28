package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "conservation")
@DiscriminatorValue("CONSERVATION")
public class Conservation extends WarrantyRepair {
    @Column(name = "date_of_next_device_conversation")
    private LocalDate dateOfNextDeviceConservation;

    @OneToOne
    @JoinColumn(name = "last_conservation_id", referencedColumnName = "id")
    private Conservation lastConservation;
}