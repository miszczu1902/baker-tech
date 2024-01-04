package pl.lodz.p.it.bakertech.service.dto.orders.update;

import jakarta.validation.constraints.NotNull;
import pl.lodz.p.it.bakertech.validation.constraint.service.OrderDuration;

import java.math.BigDecimal;
import java.util.Set;

public record UpdateForSettlementDTO(@OrderDuration @NotNull BigDecimal duration,
                                     Set<Long> devices,
                                     Boolean reportNextAutomatically) {
}
