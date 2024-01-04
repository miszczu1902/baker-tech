package pl.lodz.p.it.bakertech.service.services;

public interface ServiceScheduledTasksService {
    void updateOrdersFromOrdersQueue();

    void generateNextConservationOrders();
}
