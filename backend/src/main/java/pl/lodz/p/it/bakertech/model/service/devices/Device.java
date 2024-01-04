package pl.lodz.p.it.bakertech.model.service.devices;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.service.orders.OrderData;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.Brand;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.DeviceName;
import pl.lodz.p.it.bakertech.validation.constraint.service.device.SerialNumber;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "device", indexes = {
        @Index(name = "unique_device_snbdn", columnList = "brand,device_name,serial_number", unique = true)})
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

    @ETagField
    @Column(name = "warranty_ended", nullable = false, columnDefinition = "boolean default true")
    private Boolean warrantyEnded;

    @Enumerated(EnumType.STRING)
    @Column(name = "category_", nullable = false, updatable = false)
    private DeviceCategory category;

    @ManyToMany(mappedBy = "devices")
    private Set<OrderData> orders;
}