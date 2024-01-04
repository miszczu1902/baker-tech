package pl.lodz.p.it.bakertech.service.dto.orders.update;

public record UpdateOrderDTO(UpdateForSettlementDTO forSettlement, UpdateForCloseDTO forClose) {
}
