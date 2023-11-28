package pl.lodz.p.it.bakertech.model.service.orders.types;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Table(name = "conservation")
@DiscriminatorValue("CONSERVATION")
public class Conservation extends WarrantyRepair {
    @Column(name = "date_of_next_device_conversation")
    private LocalDate dateOfNextDeviceConservation;

    @OneToOne
    @JoinColumn(name = "last_conservation_id", referencedColumnName = "id")
    private Conservation lastConservation;
}