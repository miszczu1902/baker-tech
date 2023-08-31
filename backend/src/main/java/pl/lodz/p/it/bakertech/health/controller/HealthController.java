package pl.lodz.p.it.bakertech.health.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.lodz.p.it.bakertech.common.CommonController;
import pl.lodz.p.it.bakertech.health.dto.HealthStatusDTO;
import pl.lodz.p.it.bakertech.health.entity.TestEntity;
import pl.lodz.p.it.bakertech.health.service.HealthService;

@RestController
@RequestMapping("/health")
public class HealthController extends CommonController {
    private final HealthService healthService;

    @Autowired
    public HealthController(final HealthService healthService) {
        this.healthService = healthService;
    }

    @GetMapping
    public ResponseEntity<HealthStatusDTO> getServiceHealth() {
        healthService.test();
        return ResponseEntity.ok().body(new HealthStatusDTO("Service healthy", 200));
    }

    @GetMapping("/{testId}")
    public ResponseEntity<TestEntity> getObjectData(@PathVariable Long testId) {
        return ResponseEntity.ok().body(healthService.getTestObject(testId));
    }
}
