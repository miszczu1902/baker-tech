package pl.lodz.p.it.bakertech.service.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDetailsDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDataListDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.queue.OrderDataForQueueDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateForCloseDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateForSettlementDTO;

public interface OrdersService {
    Page<OrderDataListDTO> getOrders(Long licenseId,
                                     OrderStatus status,
                                     OrderType orderType,
                                     Boolean delayed,
                                     Pageable pageable);

    Page<OrderDataForQueueDTO> getOrdersQueue(Pageable pageable);

    OrderDetailsDTO getOrder(Long orderId);

    Long createOrder(CreateOrderDTO createOrder);

    void updateOrderStatus(Long orderId, UpdateForSettlementDTO forSettlement, UpdateForCloseDTO forClose, String ifMatch);

    void assignOrderToServiceman(Long orderId, String username, String ifMatch);
}
