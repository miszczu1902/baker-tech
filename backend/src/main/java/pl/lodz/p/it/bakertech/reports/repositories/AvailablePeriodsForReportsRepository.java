package pl.lodz.p.it.bakertech.reports.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.reports.repositories.projections.AvailablePeriodsProjection;

import java.util.List;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public interface AvailablePeriodsForReportsRepository extends JpaRepository<Order, Long> {
    @Query("SELECT DISTINCT extract(month from o.dateOfOrderExecution) AS availableMonth, " +
            "extract(year from o.dateOfOrderExecution) AS availableYear " +
            "FROM Order o " +
            "ORDER BY extract(month from o.dateOfOrderExecution), extract(year from o.dateOfOrderExecution)")
    List<AvailablePeriodsProjection> findDistinctExecutionPeriods();
}
