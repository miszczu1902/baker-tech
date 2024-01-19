package pl.lodz.p.it.bakertech.reports.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.lodz.p.it.bakertech.reports.dto.TextWithNumberReportDataDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.OrdersReportInfoDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;
import pl.lodz.p.it.bakertech.reports.services.AdminReportsService;

@RestController
@RequestMapping("/reports/admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole(@Roles.ADMINISTRATOR)")
public class AdminReportsController {
    private final AdminReportsService adminReportsService;

    @GetMapping("/percentage-of-orders")
    public ResponseEntity<PercentageOfOrdersDTO> findPercentageOfOrdersByType(@RequestParam(name = "month", required = false) Integer month,
                                                                              @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(adminReportsService.findPercentageOfOrdersByType(month, year));
    }

    @GetMapping("/orders-by-serviceman")
    public ResponseEntity<Page<TextWithNumberReportDataDTO>> getOrdersByServicemanInMonth(@PageableDefault Pageable page,
                                                                                          @RequestParam(name = "month", required = false) Integer month,
                                                                                          @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(adminReportsService.ordersByServicemanInMonth(month, year, page));
    }

    @GetMapping("/orders")
    public ResponseEntity<OrdersReportInfoDTO> getAllOrders(@RequestParam(name = "month", required = false) Integer month,
                                                            @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(adminReportsService.getOrders(month, year));
    }
}
