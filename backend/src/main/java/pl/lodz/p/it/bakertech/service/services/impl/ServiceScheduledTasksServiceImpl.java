package pl.lodz.p.it.bakertech.service.services.impl;

import org.keycloak.admin.client.Keycloak;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.exceptions.TransactionTimeoutException;
import pl.lodz.p.it.bakertech.interceptors.schedule.ScheduledInterception;
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.model.service.orders.OrderData;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.Conservation;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.repositories.ConservationRepository;
import pl.lodz.p.it.bakertech.service.repositories.OrderRepository;
import pl.lodz.p.it.bakertech.service.services.ServiceScheduledTasksService;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Set;

import static pl.lodz.p.it.bakertech.utils.SchedulePeriods.*;

@Service
@ScheduledInterception
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
@PreAuthorize("hasRole(@Roles.SYSTEM)")
public class ServiceScheduledTasksServiceImpl extends CommonService implements ServiceScheduledTasksService {
    private final OrderRepository orderRepository;
    private final ConservationRepository conservationRepository;

    @Autowired
    public ServiceScheduledTasksServiceImpl(@Value("${bakertech.keycloak.realm}") String realmName,
                                            Keycloak keycloak,
                                            KeycloakMapper keycloakMapper,
                                            ETagGenerator eTagGenerator,
                                            OrderRepository orderRepository,
                                            ConservationRepository conservationRepository) {
        super(realmName, keycloak, keycloakMapper, eTagGenerator);
        this.orderRepository = orderRepository;
        this.conservationRepository = conservationRepository;
    }

    @Override
    @Scheduled(cron = ONE_PER_DAY_ON_MIDNIGHT)
    public void updateOrdersFromOrdersQueue() {
        Set<Order> orders = orderRepository.findAllByInOrderQueueIsTrue();
        if (!orders.isEmpty()) {
            orders.forEach(order -> {
                LocalDateTime now = DateUtility.nowWithoutTimestamp(true);
                LocalDateTime dateOfOrderExecution = DateUtility.parseWithoutTimestamp(order.getDateOfOrderExecution(), true);
                if (dateOfOrderExecution.isBefore(now)) {
                    dateOfOrderExecution = now.plusDays(1);
                    order.setDateOfOrderExecution(dateOfOrderExecution).setDelayed(true);
                    if (order instanceof Conservation && dateOfOrderExecution.isAfter(DateUtility.parseWithoutTimestamp(
                            ((Conservation) order).getDateOfNextDeviceConservation(), true))) {
                        ((Conservation) order).setDateOfNextDeviceConservation(dateOfOrderExecution);
                    }
                }
                orderRepository.saveAndFlush(order);
            });
        }
    }

    @Override
    @Scheduled(cron = ONE_PER_DAY_ON_1AM)
    public void generateNextConservationOrders() {
        Set<Conservation> conservations = conservationRepository.findAllByReportNextAutomaticallyIsTrueAndStatusEquals(OrderStatus.CLOSED);
        if (!conservations.isEmpty()) {
            conservations
                    .forEach(order -> {
                        Duration period = Duration.between(
                                DateUtility.parseWithoutTimestamp(order.getDateOfOrderExecution(), true),
                                DateUtility.parseWithoutTimestamp((order.getDateOfNextDeviceConservation()), true));

                        order = orderRepository.saveAndFlush(order.setReportNextAutomatically(false));

                        Order conservation = new Conservation()
                                .setDelayed(false)
                                .setInOrderQueue(true)
                                .setOrderData(new OrderData().setDescription(order.getOrderData().getDescription()))
                                .setStatus(OrderStatus.OPEN)
                                .setOrderType(OrderType.CONSERVATION)
                                .setClient(order.getClient())
                                .setDateOfOrderExecution(order.getDateOfNextDeviceConservation());
                        ((Conservation) conservation).setLastConservation(order)
                                .setDateOfNextDeviceConservation(order.getDateOfNextDeviceConservation().plus(period))
                                .setReportNextAutomatically(true);
                        orderRepository.saveAndFlush(conservation);
                    });
        }
    }
}
