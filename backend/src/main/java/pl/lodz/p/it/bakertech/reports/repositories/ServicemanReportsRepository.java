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
public interface ServicemanReportsRepository extends JpaRepository<Order, Long> {
    @Query("SELECT AVG(o.orderData.duration) FROM Order o " +
            "WHERE o.serviceman.account.username = :username AND " +
            "(:month IS NULL OR MONTH(o.dateOfOrderExecution) = :month OR :year IS NULL OR YEAR(o.dateOfOrderExecution) = :year)")
    Double getAverageOrderTimeExecutionForServiceman(@Param("month") Integer month,
                                                     @Param("year") Integer year,
                                                     @Param("username") String username);
}
