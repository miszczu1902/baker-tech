package pl.lodz.p.it.bakertech.reports.dto.admin;

import java.math.BigDecimal;

public record OrdersReportInfoDTO(BigDecimal openedOrders,
                                  BigDecimal ordersToSettlement,
                                  BigDecimal closedOrders,
                                  BigDecimal delayedOrders) {
}
