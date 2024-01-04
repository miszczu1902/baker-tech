package pl.lodz.p.it.bakertech.service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.Conservation;

import java.util.Set;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public interface ConservationRepository extends JpaRepository<Conservation, Long> {
    @Query("SELECT c FROM Conservation c " +
            "WHERE c.status = :status " +
            "AND c.reportNextAutomatically = true " +
            "AND c.dateOfNextDeviceConservation IN (" +
            "   SELECT MAX(c2.dateOfNextDeviceConservation) " +
            "   FROM Conservation c2 " +
            "   WHERE c2.client = c.client " +
            "   AND c2.status = :status " +
            "   AND c2.reportNextAutomatically = true " +
            "   GROUP BY c2.client" +
            ")"
    )
    Set<Conservation> findAllByReportNextAutomaticallyIsTrueAndStatusEquals(@Param("status") OrderStatus status);
}
