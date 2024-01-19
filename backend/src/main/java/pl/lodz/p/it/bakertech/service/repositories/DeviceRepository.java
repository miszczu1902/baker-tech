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
import pl.lodz.p.it.bakertech.model.service.devices.Device;
import pl.lodz.p.it.bakertech.model.service.devices.DeviceCategory;
import pl.lodz.p.it.bakertech.model.service.orders.OrderData;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED,
        rollbackFor = AppException.class,
        transactionManager = "businessTransactionManager"
)
public interface DeviceRepository extends JpaRepository<Device, Long> {
    @Query("SELECT dev FROM Device dev WHERE" +
            "(:serialNumber IS NULL OR dev.serialNumber LIKE %:serialNumber%) AND " +
            "(:warrantyEnded IS NULL OR dev.warrantyEnded = :warrantyEnded) AND " +
            "(:category IS NULL OR dev.category = :category)")
    Page<Device> findAllBySerialNumberAndWarrantyAndCategory(@Param("serialNumber") String serialNumber,
                                                             @Param("warrantyEnded") Boolean warrantyEnded,
                                                             @Param("category") DeviceCategory category,
                                                             Pageable pageable);

    Page<Device> findAllByOrdersContaining(OrderData order, Pageable pageable);

    boolean existsByIdAndWarrantyEndedIsFalse(Long id);
}
