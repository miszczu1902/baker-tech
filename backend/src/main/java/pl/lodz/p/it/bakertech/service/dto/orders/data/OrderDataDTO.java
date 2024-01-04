package pl.lodz.p.it.bakertech.service.dto.orders.data;

import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.math.BigDecimal;
import java.util.Set;

public record OrderDataDTO(
        @ETagField BigDecimal duration,
        @ETagField BigDecimal totalCost,
        Set<Long> devices,
        String description
) {
}
