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
public interface OrderReportsRepository extends JpaRepository<Order, Long> {
    @Query("SELECT" +
            "(SUM(CASE WHEN " +
            "(o.serviceman.id = :servicemanId) AND " +
            "(:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month) " +
            "AND (:year IS NULL OR YEAR(o.dateOfOrderExecution) = :year) THEN 1 ELSE 0 END)) AS result " +
            "FROM Order o")
    Long findOrdersByServicemanInMonth(@Param("month") Integer month,
                                       @Param("year") Integer year,
                                       @Param("servicemanId") Long servicemanId);
}
