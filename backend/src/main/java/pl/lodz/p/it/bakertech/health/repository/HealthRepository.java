package pl.lodz.p.it.bakertech.health.repository;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonRepository;
import pl.lodz.p.it.bakertech.health.entity.TestEntity;

@Repository
@Transactional(
        propagation = Propagation.MANDATORY,
        isolation = Isolation.READ_COMMITTED
)
public interface HealthRepository extends CommonRepository<TestEntity> {
}
