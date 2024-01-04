package pl.lodz.p.it.bakertech.reports.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.service.orders.Order;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public interface ClientReportsRepository extends JpaRepository<Order, Long> {
    @Query("SELECT COUNT(DISTINCT d.id) " +
            "FROM Order o " +
            "JOIN o.orderData od " +
            "JOIN od.devices d " +
            "WHERE ((:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) " +
            "AND (:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month)) " +
            "AND d.warrantyEnded = false AND o.orderType = 'WARRANTY_REPAIR' " +
            "AND o.client.account.username = :clientUsername")
    Long countDevicesUnderWarrantyByMonth(@Param("month") Integer month,
                                          @Param("year") Integer year,
                                          @Param("clientUsername") String clientUsername);

    @Query("SELECT COUNT(o.id) " +
            "FROM Order o " +
            "JOIN o.client c " +
            "WHERE c.account.username = :username " +
            "AND (:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) " +
            "AND (:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month)")
    Long countOrdersForClientByUsernameAndMonth(@Param("month") Integer month,
                                                @Param("year") Integer year,
                                                @Param("username") String username);
}
