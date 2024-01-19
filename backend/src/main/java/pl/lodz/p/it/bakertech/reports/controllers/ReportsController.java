package pl.lodz.p.it.bakertech.reports.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.lodz.p.it.bakertech.reports.dto.AvailableDatesDTO;
import pl.lodz.p.it.bakertech.reports.services.AvailablePeriodsForReportsService;

@RestController
@RequestMapping("/reports")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole(@Roles.ADMINISTRATOR, @Roles.SERVICEMAN, @Roles.CLIENT)")
public class ReportsController {
    private final AvailablePeriodsForReportsService availablePeriodsForReportsService;

    @GetMapping("/dates")
    public ResponseEntity<AvailableDatesDTO> availablePeriodsForReports() {
        return ResponseEntity.ok(availablePeriodsForReportsService.availablePeriodsForReports());
    }
}
