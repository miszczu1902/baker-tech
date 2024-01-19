package pl.lodz.p.it.bakertech.service.controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.service.dto.devices.AddDeviceDTO;
import pl.lodz.p.it.bakertech.service.dto.devices.DeviceListDataDTO;
import pl.lodz.p.it.bakertech.service.services.DeviceService;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.net.URI;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.API_URI;

@RestController
@RequestMapping("/devices")
@RequiredArgsConstructor
public class DeviceController {
    private final DeviceService deviceService;
    private final ETagGenerator eTagGenerator;

    @GetMapping
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Page<DeviceListDataDTO>> getDevices(@PageableDefault Pageable pageable,
                                                              @RequestParam(required = false) final String serialNumber,
                                                              @RequestParam(required = false) final Boolean warrantyEnded,
                                                              @RequestParam(required = false) final DeviceCategory category) {
        return ResponseEntity.ok(deviceService.getDevices(serialNumber, warrantyEnded, category, pageable));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Page<DeviceListDataDTO>> getDeviceETag(@PathVariable final Long id) {
        return ResponseEntity.status(HttpStatus.OK)
                .eTag(eTagGenerator.generateETagValue(deviceService.getDevice(id)))
                .build();
    }

    @GetMapping("/devices-for-order/{orderId}")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public ResponseEntity<Page<DeviceListDataDTO>> getDevicesForSpecifiedOrder(@PageableDefault Pageable pageable,
                                                                               @PathVariable final Long orderId) {
       return ResponseEntity.ok(deviceService.getDevicesForOrder(orderId, pageable));
    }

    @PostMapping
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Page<DeviceListDataDTO>> addDeviceToService(@Valid @RequestBody final AddDeviceDTO addDevice) {
        return ResponseEntity.created(
                URI.create("%s/devices/%s".formatted(API_URI, deviceService.addDeviceToService(addDevice)))
        ).build();
    }

    @PostMapping("/{id}/mark-ended-warranty")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Void> markDeviceWarrantyAsEnded(@PathVariable final Long id,
                                                          @RequestHeader("If-Match") final String ifMatch) {
        deviceService.markEndedWarrantyForDevice(id, ifMatch);
        return ResponseEntity.noContent().build();
    }
}
