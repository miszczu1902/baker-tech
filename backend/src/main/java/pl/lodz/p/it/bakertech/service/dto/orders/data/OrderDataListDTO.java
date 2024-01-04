package pl.lodz.p.it.bakertech.service.dto.orders.data;

import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;

import java.time.LocalDateTime;

public record OrderDataListDTO(Long id,
                               String licenseId,
                               String username,
                               OrderType orderType,
                               OrderStatus status,
                               LocalDateTime dateOfOrderExecution,
                               Boolean delayed
) {
}
