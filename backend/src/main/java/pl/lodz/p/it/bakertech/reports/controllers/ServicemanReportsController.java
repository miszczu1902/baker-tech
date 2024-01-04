package pl.lodz.p.it.bakertech.reports.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.lodz.p.it.bakertech.reports.dto.TextWithNumberReportDataDTO;
import pl.lodz.p.it.bakertech.reports.dto.NumberValueDTO;
import pl.lodz.p.it.bakertech.reports.services.ServicemanReportsService;

@RestController
@RequestMapping("/reports/serviceman")
@RequiredArgsConstructor
@PreAuthorize("hasRole(@Roles.SERVICEMAN)")
public class ServicemanReportsController {
    private final ServicemanReportsService servicemanReportsService;

    @GetMapping("/average-time")
    public ResponseEntity<NumberValueDTO> getAverageTime(@RequestParam(name = "month", required = false) Integer month,
                                                         @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(servicemanReportsService.getAverageOrderTimeExecution(month, year));
    }

    @GetMapping("/orders-in-time")
    public ResponseEntity<TextWithNumberReportDataDTO> getOrdersByServicemanInMonth(@RequestParam(name = "month", required = false) Integer month,
                                                                                    @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(servicemanReportsService.getAmountOfOrdersExecutedByServiceman(month, year));
    }
    @GetMapping("/the-most-repaired-device-category")
    public ResponseEntity<TextWithNumberReportDataDTO> getTheMostFrequentlyRepairedTypeOfDevicesInService(@RequestParam(name = "month", required = false) Integer month,
                                                                                                          @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(servicemanReportsService.getTheMostFrequentlyRepairedTypeOfDevicesInService(month, year));
    }
}
