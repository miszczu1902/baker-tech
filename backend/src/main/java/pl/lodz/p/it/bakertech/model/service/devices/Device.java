package pl.lodz.p.it.bakertech.model.service.devices;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import pl.lodz.p.it.bakertech.common.AbstractEntity;
import pl.lodz.p.it.bakertech.validation.constraint.orders.device.Brand;
import pl.lodz.p.it.bakertech.validation.constraint.orders.device.DeviceName;
import pl.lodz.p.it.bakertech.validation.constraint.orders.device.SerialNumber;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "device", indexes = {
        @Index(name = "unique_device_sn", columnList = "serial_number", unique = true),
        @Index(name = "unique_device_bdn", columnList = "brand,device_name", unique = true)},
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "device_unique", columnNames = {"serial_number"})
        })
public class Device extends AbstractEntity {
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
    @Column(name = "category", nullable = false, updatable = false)
    private DeviceCategory category;
}