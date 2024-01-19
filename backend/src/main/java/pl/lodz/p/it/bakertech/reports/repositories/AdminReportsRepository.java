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
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.reports.repositories.projections.OrderStatusCountInPeriodProjection;
import pl.lodz.p.it.bakertech.reports.repositories.projections.PercentageOrdersProjection;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
public interface AdminReportsRepository extends JpaRepository<Order, Long> {
    @Query("SELECT" +
            "(SUM(CASE WHEN o.orderType = 'NON_WARRANTY_REPAIR' THEN 1 ELSE 0 END) * 100.0 / COUNT(o)) AS nonWarrantyRepair, " +
            "(SUM(CASE WHEN o.orderType = 'WARRANTY_REPAIR' THEN 1 ELSE 0 END) * 100.0 / COUNT(o)) AS warrantyRepair, " +
            "(SUM(CASE WHEN o.orderType = 'CONSERVATION' THEN 1 ELSE 0 END) * 100.0 / COUNT(o)) AS conservation " +
            "FROM Order o " +
            "WHERE ((:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month) " +
            "AND (:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year))")
    PercentageOrdersProjection findPercentageOfOrdersByTypeWithDefault(@Param("month") Integer month,
                                                                       @Param("year") Integer year);

    @Query("SELECT" +
            "(SUM(CASE WHEN " +
            "(o.status = :status) AND " +
            "(:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month) " +
            "AND (:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) THEN 1 ELSE 0 END)) AS value " +
            "FROM Order o")
    OrderStatusCountInPeriodProjection findByMonthYearOrderStatus(@Param("month") Integer month,
                                                                  @Param("year") Integer year,
                                                                  @Param("status") OrderStatus status);

    @Query("SELECT" +
            "(SUM(CASE WHEN " +
            "(o.delayed = true) AND " +
            "(:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month) " +
            "AND (:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) THEN 1 ELSE 0 END)) AS value " +
            "FROM Order o")
    OrderStatusCountInPeriodProjection findByDelayed(@Param("month") Integer month, @Param("year") Integer year);
}
