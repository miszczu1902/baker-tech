package pl.lodz.p.it.bakertech.service.dto.orders.create;

import java.time.LocalDateTime;

public record NextOrderDataDTO(
        LocalDateTime lastDateOfDeviceService,
        LocalDateTime dateOfNextDeviceConservation
) {
}
