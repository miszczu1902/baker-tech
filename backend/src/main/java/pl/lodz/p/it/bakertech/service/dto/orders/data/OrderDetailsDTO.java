package pl.lodz.p.it.bakertech.service.dto.orders.data;

import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

public record OrderDetailsDTO(
        Long id,
        @ETagField Long version,
        Long servicemanId,
        String licenseId,
        String client,
        Long clientId,
        @ETagField OrderStatus status,
        Boolean delayed,
        Boolean inOrderQueue,
        OrderType orderType,
        OrderDataDTO orderData,
        ConservationDTO conservation,
        WarrantyRepairDTO warrantyRepair){
}
