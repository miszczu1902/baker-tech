package pl.lodz.p.it.bakertech.integration.schedule;

import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.EnumSource;
import org.springframework.beans.factory.annotation.Autowired;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;
import pl.lodz.p.it.bakertech.interceptors.schedule.ScheduledTasksInterceptor;
import pl.lodz.p.it.bakertech.model.service.orders.types.Conservation;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.repositories.OrderRepository;
import pl.lodz.p.it.bakertech.service.services.ServiceScheduledTasksService;
import pl.lodz.p.it.bakertech.utils.DateUtility;

import java.util.List;

public class ScheduledTests extends BakerTechIntegrationTestConfig {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ServiceScheduledTasksService scheduler;

    @Autowired
    private ScheduledTasksInterceptor interceptor;

    @BeforeEach
    public void initTest() {
        initDb();
        interceptor.beforeScheduledMethod();
    }

    @AfterEach
    public void afterTest() {
        interceptor.afterScheduledMethod();
    }

    @Test
    void success_generateNextConservationOrderTest() {
        List.of(-26, -25)
                .forEach(orderId -> orderRepository.delete(orderRepository
                        .findById(orderId.longValue())
                        .orElseThrow()));
        int oldSize = orderRepository.findAll().size();
        var order = (Conservation) orderRepository.findById(-18L).orElseThrow();
        order.setReportNextAutomatically(true);
        order.setDateOfNextDeviceConservation(DateUtility.nowWithoutTimestamp(true).minusDays(1));
        orderRepository.saveAndFlush(order);

        scheduler.generateNextConservationOrders();
        Assertions.assertTrue(orderRepository.findAll().size() > oldSize);
    }

    @ParameterizedTest
    @EnumSource(OrderType.class)
    void success_updateOrdersFromOrdersQueueTest(OrderType orderType) {
        long orderId;
        switch (orderType) {
            case CONSERVATION -> orderId = -26L;
            case WARRANTY_REPAIR -> orderId = -28L;
            default -> orderId = -27L;
        }

        var order = orderRepository.findById(orderId).orElseThrow();
        order.setDateOfOrderExecution(DateUtility.nowWithoutTimestamp(true).minusDays(1));
        orderRepository.saveAndFlush(order);

        scheduler.updateOrdersFromOrdersQueue();
        order = orderRepository.findById(orderId).orElseThrow();
        Assertions.assertTrue(order.getInOrderQueue());
        Assertions.assertTrue(order.getDelayed());
        Assertions.assertEquals(DateUtility.nowWithoutTimestamp(true).plusDays(1), order.getDateOfOrderExecution());
    }
}
