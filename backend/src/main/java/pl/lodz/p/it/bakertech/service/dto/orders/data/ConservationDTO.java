package pl.lodz.p.it.bakertech.service.dto.orders.data;

import java.time.LocalDateTime;

public record ConservationDTO(LocalDateTime dateOfNextDeviceConservation, Long lastConservation) {
}
