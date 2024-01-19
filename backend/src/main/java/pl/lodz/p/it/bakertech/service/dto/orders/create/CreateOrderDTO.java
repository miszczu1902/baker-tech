package pl.lodz.p.it.bakertech.service.dto.orders.create;

import jakarta.validation.constraints.NotNull;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.validation.constraint.service.Order;

@Order
public record CreateOrderDTO(
        @NotNull String client,
        @NotNull String description,
        @NotNull OrderType orderType,
        NextOrderDataDTO nextOrderData
) {
}
