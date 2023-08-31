package pl.lodz.p.it.bakertech.health.service;

import pl.lodz.p.it.bakertech.health.entity.TestEntity;

public interface HealthService {
    void test();

    TestEntity getTestObject(Long id);
}
