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
import pl.lodz.p.it.bakertech.model.service.orders.types.Conservation;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;

import java.util.Optional;
import java.util.Set;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByIdAndStatus(Long id, OrderStatus status);

    boolean existsByIdAndServiceman_AccessLevelNameAndServiceman_Account_Username(Long id, String accessLevelName, String username);

    @Query("SELECT o FROM Order o LEFT JOIN o.serviceman WHERE" +
            "((CAST(:status as string) = 'OPEN' AND o.serviceman IS NULL) OR :licenseId IS NULL OR o.serviceman.licenseId = :licenseId) AND " +
            "(:status IS NULL OR o.status = :status) AND " +
            "(:orderType IS NULL OR o.orderType = :orderType) AND " +
            "(:delayed IS NULL OR o.delayed = :delayed) AND " +
            "(:client IS NULL OR o.client.account.username = :client)")
    Page<Order> findAllByLicenseIdAndStatusAndOrderTypeAndDelayedAndClient(@Param("licenseId") Long licenseId,
                                                                           @Param("status") OrderStatus status,
                                                                           @Param("orderType") OrderType orderType,
                                                                           @Param("delayed") Boolean delayed,
                                                                           @Param("client") String client,
                                                                           Pageable pageable);

    @Query("SELECT o FROM Order o LEFT JOIN o.serviceman WHERE" +
            "(:status IS NULL OR o.status = :status) AND " +
            "(:orderType IS NULL OR o.orderType = :orderType) AND " +
            "(:delayed IS NULL OR o.delayed = :delayed) AND " +
            "(:client IS NULL OR o.client.account.username = :client)")
    Page<Order> findAllForClient(@Param("status") OrderStatus status,
                                 @Param("orderType") OrderType orderType,
                                 @Param("delayed") Boolean delayed,
                                 @Param("client") String client,
                                 Pageable pageable);

    @Query("SELECT o FROM Order o WHERE" +
            "(:username IS NULL OR o.serviceman.account.username = :username) AND " +
            "(:status IS NULL OR o.status = :status) AND " +
            "(:orderType IS NULL OR o.orderType = :orderType) AND " +
            "(:delayed IS NULL OR o.delayed = :delayed) AND " +
            "(:client IS NULL OR o.client.account.username LIKE %:client%)")
    Page<Order> findAllForServicemanByLicenseIdAndStatusAndOrderTypeAndDelayedAndClient(@Param("username") String username,
                                                                                        @Param("status") OrderStatus status,
                                                                                        @Param("orderType") OrderType orderType,
                                                                                        @Param("delayed") Boolean delayed,
                                                                                        @Param("client") String client,
                                                                                        Pageable pageable);

    Set<Order> findAllByInOrderQueueIsTrue();

    @Query("SELECT o FROM Order o WHERE o.inOrderQueue = TRUE ORDER BY o.delayed DESC, o.dateOfOrderExecution ASC")
    Page<Order> findAllForOrdersQueue(Pageable pageable);

    @Query("SELECT c FROM Conservation c WHERE c.lastConservation.id = :conservationId")
    Optional<Conservation> findConservationAfterSpecifiedConservation(@Param("conservationId") Long conservationId);
}
