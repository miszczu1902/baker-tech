package pl.lodz.p.it.bakertech.health.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pl.lodz.p.it.bakertech.common.CommonService;
import pl.lodz.p.it.bakertech.common.interceptors.Interception;
import pl.lodz.p.it.bakertech.health.entity.TestEntity;
import pl.lodz.p.it.bakertech.health.repository.HealthRepository;

@Service
@Interception
@Transactional(
        propagation = Propagation.REQUIRES_NEW,
        isolation = Isolation.READ_COMMITTED
)
public class HealthServiceImpl extends CommonService implements HealthService {
    private final HealthRepository healthRepository;

    @Autowired
    public HealthServiceImpl(HealthRepository healthRepository) {
        this.healthRepository = healthRepository;
    }

    public void test() {
    }

    @Override
    public TestEntity getTestObject(Long id) {
        return healthRepository.findById(id).orElseThrow();
    }
}
