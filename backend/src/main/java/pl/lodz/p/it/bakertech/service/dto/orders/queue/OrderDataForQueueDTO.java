package pl.lodz.p.it.bakertech.service.dto.orders.queue;

import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;

import java.time.LocalDateTime;

public record OrderDataForQueueDTO(Long id,
                                   String client,
                                   String address,
                                   LocalDateTime dateOfOrderExecution,
                                   OrderType orderType,
                                   Boolean delayed) {
}
