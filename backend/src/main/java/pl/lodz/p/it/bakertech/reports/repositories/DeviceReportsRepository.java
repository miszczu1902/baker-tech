package pl.lodz.p.it.bakertech.reports.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.reports.repositories.projections.RepairedDeviceProjection;
import pl.lodz.p.it.bakertech.reports.repositories.projections.ServicedDevicesProjection;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
public interface DeviceReportsRepository extends JpaRepository<Device, Long> {
    @Query("SELECT " +
            "d.category AS category, COUNT(d.id) as value " +
            "FROM Order o " +
            "JOIN o.orderData od " +
            "JOIN od.devices d " +
            "WHERE ((:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) " +
            "AND (:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month)) " +
            "GROUP BY d.category " +
            "ORDER BY COUNT(d.id) DESC LIMIT 1")
    RepairedDeviceProjection getTheMostFrequentlyRepairedTypeOfDevices(@Param("month") Integer month,
                                                                       @Param("year") Integer year);

    @Query("SELECT d.brand as brand, " +
            "d.category as category, " +
            "d.deviceName as deviceName, " +
            "d.serialNumber as serialNumber " +
            "FROM Order o " +
            "JOIN o.orderData od " +
            "JOIN od.devices d " +
            "WHERE o.client.account.username = :username " +
            "AND (:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) " +
            "AND (:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month)")
    Page<ServicedDevicesProjection> getDevicesServicedForClient(@Param("month") Integer month,
                                                                @Param("year") Integer year,
                                                                @Param("username") String username,
                                                                Pageable pageable);
}
