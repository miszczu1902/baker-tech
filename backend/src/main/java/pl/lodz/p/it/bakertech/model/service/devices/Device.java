package pl.lodz.p.it.bakertech.model.service.devices;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.service.orders.OrderData;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.Brand;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.DeviceName;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.SerialNumber;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "device", indexes = {
        @Index(name = "unique_device_sn", columnList = "serial_number", unique = true),
        @Index(name = "unique_device_bdn", columnList = "brand,device_name", unique = true)},
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "device_unique", columnNames = {"serial_number"})
        })
public class Device extends AbstractEntityWithId {
    @DeviceName
    @Column(name = "device_name", nullable = false, updatable = false)
    private String deviceName;

    @Brand
    @Column(name = "brand", nullable = false, updatable = false)
    private String brand;

    @SerialNumber
    @Column(name = "serial_number")
    private String serialNumber;

    @Column(name = "warranty_ended", nullable = false, columnDefinition = "BOOLEAN DEFAULT TRUE")
    private Boolean warrantyEnded;

    @Enumerated(EnumType.STRING)
    @Column(name = "category", nullable = false, updatable = false, columnDefinition = "device_category")
    private DeviceCategory category;

    @ManyToMany(mappedBy = "device")
    private Set<OrderData> orders;
}