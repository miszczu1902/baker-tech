package pl.lodz.p.it.bakertech.service.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.exceptions.ForbiddenException;
import pl.lodz.p.it.bakertech.exceptions.TransactionTimeoutException;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.model.service.orders.OrderData;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.Conservation;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameter;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.NextConservationDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.queue.OrderDataForQueueDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateForCloseDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateForSettlementDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDataListDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.data.OrderDetailsDTO;
import pl.lodz.p.it.bakertech.service.exceptions.*;
import pl.lodz.p.it.bakertech.service.repositories.AccessLevelServiceRepository;
import pl.lodz.p.it.bakertech.service.repositories.DeviceRepository;
import pl.lodz.p.it.bakertech.service.repositories.OrderRepository;
import pl.lodz.p.it.bakertech.service.repositories.ServiceParametersRepository;
import pl.lodz.p.it.bakertech.service.services.OrdersService;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.utils.mappers.service.OrderMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.time.LocalDateTime;
import java.util.Optional;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.ROUNDING_PRECISION;

@Service
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
@Retryable(
        retryFor = TransactionTimeoutException.class,
        maxAttemptsExpression = "${bakertech.transaction.retry}",
        backoff = @Backoff(delayExpression = "${bakertech.transaction.retry.delay}")
)
public class OrdersServiceImpl extends CommonService implements OrdersService {
    private final OrderRepository orderRepository;
    private final DeviceRepository deviceRepository;
    private final AccessLevelServiceRepository accessLevelServiceRepository;
    private final ServiceParametersRepository serviceParametersRepository;
    private final OrderMapper orderMapper;

    @Autowired
    public OrdersServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                             Keycloak keycloak,
                             KeycloakMapper keycloakMapper,
                             ETagGenerator eTagGenerator,
                             OrderMapper orderMapper,
                             OrderRepository orderRepository,
                             DeviceRepository deviceRepository,
                             AccessLevelServiceRepository accessLevelServiceRepository,
                             ServiceParametersRepository serviceParametersRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.orderMapper = orderMapper;
        this.orderRepository = orderRepository;
        this.deviceRepository = deviceRepository;
        this.accessLevelServiceRepository = accessLevelServiceRepository;
        this.serviceParametersRepository = serviceParametersRepository;
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public Page<OrderDataListDTO> getOrders(Long licenseId,
                                            OrderStatus status,
                                            OrderType orderType,
                                            Boolean delayed,
                                            String client,
                                            Pageable pageable) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        boolean responseCondition = Roles.getAuthenticatedRoles()
                .stream()
                .anyMatch(role -> role.equals(Roles.CLIENT)
                        ? (Optional.ofNullable(client).isPresent() && client.equals(username))
                        : accessLevelServiceRepository.existsByAccessLevelNameAndAccount_Username(role, username)
                );
        if (responseCondition) {
            Page<Order> orders;
            if (accessLevelServiceRepository.existsByAccessLevelNameAndAccount_Username(Roles.CLIENT, username)
                    && (Optional.ofNullable(client).isPresent() && client.equals(username))) {
                orders = orderRepository.findAllForClient(status, orderType, delayed, client, pageable);
            } else {
                orders = orderRepository
                        .findAllByLicenseIdAndStatusAndOrderTypeAndDelayedAndClient(
                                licenseId,
                                status,
                                orderType,
                                delayed,
                                client,
                                pageable);
            }
            return new PageImpl<>(orders.get()
                    .map(orderMapper::orderEntityToOrderListData)
                    .toList(),
                    orders.getPageable(),
                    orders.getTotalElements());
        } else {
            throw ForbiddenException.createException();
        }
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public Page<OrderDataForQueueDTO> getOrdersQueue(Pageable pageable) {
        Page<Order> ordersQueue = orderRepository.findAllForOrdersQueue(pageable);
        return new PageImpl<>(ordersQueue.get()
                .map(orderMapper::orderEntityToOrderDataForQueue)
                .toList(),
                ordersQueue.getPageable(),
                ordersQueue.getTotalElements());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public OrderDetailsDTO getOrder(Long orderId) {
        return orderMapper.orderEntityToOrderDetails(orderRepository.findById(orderId).orElseThrow());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.SERVICEMAN, @Roles.CLIENT)")
    public Long createOrder(final CreateOrderDTO createOrder) {
        Order orderToCreate;
        final LocalDateTime now = DateUtility.nowWithoutTimestamp(true);

        switch (createOrder.orderType()) {
            case CONSERVATION -> orderToCreate = orderMapper.createOrderToConservationEntity(createOrder);
            case WARRANTY_REPAIR -> orderToCreate = orderMapper.createOrderToWarrantyRepairEntity(createOrder);
            default -> orderToCreate = orderMapper.createOrderToNonWarrantyRepairEntity(createOrder);
        }

        final ServiceParameter serviceParameters = serviceParametersRepository
                .findByServiceParameterTypeEquals(ServiceParameterType.CUT_OFF_DATE_PERIOD)
                .orElseThrow();
        orderToCreate.setDateOfOrderExecution(now.plusDays(serviceParameters.getValue().longValue()))
                .setClient((Client) accessLevelServiceRepository
                        .findByAccessLevelNameAndAccount_Username(Roles.CLIENT, createOrder.client()).orElseThrow());

        if (createOrder.orderType() == OrderType.CONSERVATION) {
            LocalDateTime dateOfNextDeviceConservation = DateUtility.parseWithoutTimestamp(
                    createOrder.nextOrderData().dateOfNextDeviceConservation(), true);
            if (orderToCreate.getDateOfOrderExecution().isAfter(dateOfNextDeviceConservation)) {
                orderToCreate.setDateOfOrderExecution(dateOfNextDeviceConservation);
            }
        }

        return orderRepository.saveAndFlush(orderToCreate).getId();
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN)")
    public void updateOrderStatus(final Long orderId,
                                  final UpdateForSettlementDTO forSettlement,
                                  final UpdateForCloseDTO forClose,
                                  final String ifMatch) {
        final String username = SecurityContextHolder.getContext().getAuthentication().getName();
        final Order order = orderRepository.findById(orderId).orElseThrow();
        final LocalDateTime now = DateUtility.nowWithoutTimestamp(false);

        if (ifMatch.equals(eTagGenerator.generateETagValue(order))) {
            switch (order.getStatus()) {
                case IN_PROGRESS -> {
                    if (orderRepository.existsByIdAndServiceman_AccessLevelNameAndServiceman_Account_Username(orderId, Roles.SERVICEMAN, username)) {
                        LocalDateTime potentialEndTime = DateUtility.parseWithoutTimestamp(order.getCreationDateTime(), true)
                                .plusHours(forSettlement.duration().longValue());
                        if (potentialEndTime.isAfter(now)) {
                            throw CannotUpdateOrderException.createException();
                        }
                        final OrderData orderData = order.getOrderData();
                        final ServiceParameter unitCost = serviceParametersRepository
                                .findByServiceParameterTypeEquals(ServiceParameterType.UNIT_COST_OF_WORKING_HOUR)
                                .orElseThrow();

                        order.setDateOfOrderExecution(now)
                                .setStatus(OrderStatus.FOR_SETTLEMENT);
                        orderData.setDuration(forSettlement.duration())
                                .setTotalCost(unitCost.getValue()
                                        .multiply(forSettlement.duration(), ROUNDING_PRECISION));
                        Optional.ofNullable(forSettlement.devices())
                                .ifPresent(devices -> {
                                    if (order.getOrderType() == OrderType.WARRANTY_REPAIR) {
                                        if (devices.size() != 1) {
                                            throw CannotAssignMoreDeviceToWarrantyRepairException.createException();
                                        }
                                        boolean allDevicesHasWarranty = devices.stream().allMatch(deviceRepository::existsByIdAndWarrantyEndedIsFalse);
                                        if (allDevicesHasWarranty) {
                                            orderData.getDevices().addAll(deviceRepository.findAllById(devices));
                                        } else {
                                            throw CannotAssignNonWarrantyDeviceToWarrantyRepairException.createException();
                                        }
                                    } else {
                                        devices.forEach(deviceId -> orderData.getDevices()
                                                .add(deviceRepository.findById(deviceId).orElseThrow()));
                                    }
                                });
                        if (order instanceof Conservation) {
                            ((Conservation) order)
                                    .setReportNextAutomatically(Optional.ofNullable(forSettlement.reportNextAutomatically())
                                            .orElse(((Conservation) order).getReportNextAutomatically()));
                        }
                    } else {
                        throw CannotUpdateNotYourselfOrderException.createExcpetion();
                    }
                }
                case FOR_SETTLEMENT -> {
                    if (accessLevelServiceRepository.existsByAccessLevelNameAndAccount_Username(Roles.ADMINISTRATOR, username)
                            && !orderRepository.existsByIdAndServiceman_AccessLevelNameAndServiceman_Account_Username(orderId, Roles.SERVICEMAN, username)) {
                        Optional.ofNullable(forClose)
                                .ifPresent(closing -> order.getOrderData()
                                        .setTotalCost(Optional.ofNullable(closing.totalCost())
                                                .orElse(order.getOrderData().getTotalCost())));
                        order.setStatus(OrderStatus.CLOSED);
                    } else {
                        throw CannotSettleOrderByYourselfException.createExcpetion();
                    }
                }
                default -> throw CannotUpdateOrderException.createException();
            }
            orderRepository.saveAndFlush(order);
        } else {
            throw AppException.createContentWasChangedException();
        }
    }


    @Override
    @PreAuthorize("hasRole(@Roles.SERVICEMAN)")
    public void assignOrderToServiceman(final Long orderId, final String username, final String ifMatch) {
        final Serviceman serviceman = (Serviceman) accessLevelServiceRepository
                .findByAccessLevelNameAndAccount_Username(Roles.SERVICEMAN, username)
                .orElseThrow();
        final Order order = orderRepository.findByIdAndStatus(orderId, OrderStatus.OPEN).orElseThrow();
        if (ifMatch.equals(eTagGenerator.generateETagValue(order))) {
            order.setServiceman(serviceman);
            order.setStatus(OrderStatus.IN_PROGRESS);
            order.setInOrderQueue(false);
            orderRepository.saveAndFlush(order);
        } else {
            throw AppException.createContentWasChangedException();
        }

    }

    @Override
    @PreAuthorize("hasRole(@Roles.SERVICEMAN)")
    public Page<OrderDataListDTO> getOrdersAssignedToServiceman(OrderStatus status,
                                                                OrderType orderType,
                                                                Boolean delayed,
                                                                String client,
                                                                Pageable pageable) {
        Page<Order> orders = orderRepository
                .findAllForServicemanByLicenseIdAndStatusAndOrderTypeAndDelayedAndClient(
                        SecurityContextHolder.getContext().getAuthentication().getName(),
                        status,
                        orderType,
                        delayed,
                        client,
                        pageable);
        return new PageImpl<>(orders.get()
                .map(orderMapper::orderEntityToOrderListData)
                .toList(),
                orders.getPageable(),
                orders.getTotalElements());
    }

    @Override
    @PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
    public NextConservationDTO getNextConservationForSpecifiedConservation(Long conservationId) {
        String username = SecurityContextHolder.getContext()
                .getAuthentication()
                .getName();
        boolean clientCondition = accessLevelServiceRepository.existsByAccessLevelNameAndAccount_Username(Roles.CLIENT, username);
        Optional<Conservation> conservation = orderRepository.findConservationAfterSpecifiedConservation(conservationId);

        return conservation.map(order -> {
            if (!clientCondition || username.equals(conservation.get().getClient().getAccount().getUsername())) {
                return conservation.map(value -> new NextConservationDTO(value.getId())).orElse(null);
            }
            throw ForbiddenException.createException();
        }).orElse(null);
    }
}