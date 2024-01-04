package pl.lodz.p.it.bakertech.service.dto.orders.create;

import jakarta.validation.constraints.NotNull;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;

public record CreateOrderDTO(
        @NotNull Long client,
        @NotNull String description,
        @NotNull OrderType orderType,
        NextOrderDataDTO nextOrderData
) {
}
