package pl.lodz.p.it.bakertech.service.controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.NextConservationDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDataListDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.queue.OrderDataForQueueDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDetailsDTO;
import pl.lodz.p.it.bakertech.service.services.OrdersService;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.net.URI;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.API_URI;

@RestController
@RequestMapping("/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrdersService ordersService;
    private final ETagGenerator eTagGenerator;

    @GetMapping
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public ResponseEntity<Page<OrderDataListDTO>> getOrders(@PageableDefault Pageable pageable,
                                                            @RequestParam(required = false) final Long licenseId,
                                                            @RequestParam(required = false) final OrderStatus status,
                                                            @RequestParam(required = false) final OrderType orderType,
                                                            @RequestParam(required = false) final Boolean delayed,
                                                            @RequestParam(required = false) final String client
    ) {
        return ResponseEntity.ok(ordersService.getOrders(licenseId, status, orderType, delayed, client, pageable));
    }

    @GetMapping("/orders-queue")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Page<OrderDataForQueueDTO>> getOrdersQueue(@PageableDefault Pageable pageable) {
        return ResponseEntity.ok(ordersService.getOrdersQueue(pageable));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public ResponseEntity<OrderDetailsDTO> getOrder(@PathVariable final Long id) {
        var result = ordersService.getOrder(id);
        return ResponseEntity.status(HttpStatus.OK)
                .eTag(eTagGenerator.generateETagValue(result))
                .body(result);
    }

    @PostMapping
    @PreAuthorize("hasAnyRole(@Roles.SERVICEMAN, @Roles.CLIENT)")
    public ResponseEntity<Void> createOrder(@Valid @RequestBody final CreateOrderDTO createOrder) {
        return ResponseEntity.created(
                URI.create("%s/orders/%s".formatted(API_URI, ordersService.createOrder(createOrder)))
        ).build();
    }

    @PostMapping("/{id}/assign-serviceman")
    @PreAuthorize("hasRole(@Roles.SERVICEMAN)")
    public ResponseEntity<Void> assignOrderToServicemanAccount(@PathVariable final Long id,
                                                               @RequestHeader("If-Match") final String ifMatch) {
        ordersService.assignOrderToServiceman(id, SecurityContextHolder.getContext().getAuthentication().getName(), ifMatch);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public ResponseEntity<Void> updateOrderData(@PathVariable final Long id,
                                                @RequestBody @Valid final UpdateOrderDTO updateOrder,
                                                @RequestHeader("If-Match") final String ifMatch) {
        ordersService.updateOrderStatus(id, updateOrder.forSettlement(), updateOrder.forClose(), ifMatch);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/assigned-to-serviceman")
    @PreAuthorize("hasRole(@Roles.SERVICEMAN)")
    public ResponseEntity<Page<OrderDataListDTO>> getOrdersAssignedToServiceman(@PageableDefault Pageable pageable,
                                                                                @RequestParam(required = false) final OrderStatus status,
                                                                                @RequestParam(required = false) final OrderType orderType,
                                                                                @RequestParam(required = false) final Boolean delayed,
                                                                                @RequestParam(required = false) final String client) {
        return ResponseEntity.ok(ordersService.getOrdersAssignedToServiceman(status, orderType, delayed, client, pageable));
    }

    @GetMapping("/{id}/next-conservation")
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public ResponseEntity<NextConservationDTO> getOrders(@PathVariable Long id) {
        return ResponseEntity.ok(ordersService.getNextConservationForSpecifiedConservation(id));
    }
}