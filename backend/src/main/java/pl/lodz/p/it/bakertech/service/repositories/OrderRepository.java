package pl.lodz.p.it.bakertech.service.repositories;

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
import pl.lodz.p.it.bakertech.model.service.orders.Order;
import pl.lodz.p.it.bakertech.model.service.orders.OrderStatus;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;

import java.util.Optional;
import java.util.Set;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class
)
public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByIdAndStatus(Long id, OrderStatus status);

    boolean existsByIdAndServiceman_AccessLevelNameAndServiceman_Account_Username(Long id, String accessLevelName, String username);

    @Query("SELECT o FROM Order o WHERE" +
            "(:licenseId IS NULL OR o.serviceman.licenseId = :licenseId) AND " +
            "(:status IS NULL OR o.status = :status) AND " +
            "(:orderType IS NULL OR o.orderType = :orderType) AND " +
            "(:delayed IS NULL OR o.delayed = :delayed)")
    Page<Order> findAllByLicenseIdAndStatusAndOrderTypeAndDelayed(@Param("licenseId") Long licenseId,
                                                                  @Param("status") OrderStatus status,
                                                                  @Param("orderType") OrderType orderType,
                                                                  @Param("delayed") Boolean delayed,
                                                                  Pageable pageable);

    Set<Order> findAllByInOrderQueueIsTrue();

    @Query("SELECT o FROM Order o WHERE o.inOrderQueue = TRUE ORDER BY o.delayed DESC, o.dateOfOrderExecution DESC")
    Page<Order> findAllForOrdersQueue(Pageable pageable);
}
