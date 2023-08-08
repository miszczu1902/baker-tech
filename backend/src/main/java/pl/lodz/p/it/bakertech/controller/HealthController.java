package pl.lodz.p.it.bakertech.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.lodz.p.it.bakertech.dto.HealthStatusDTO;

@RestController
public class HealthController {

    @GetMapping("/health")
    public ResponseEntity<HealthStatusDTO> getServiceHealth() {
        return ResponseEntity.ok().body(new HealthStatusDTO("Service healthy", 200));
    }

}
