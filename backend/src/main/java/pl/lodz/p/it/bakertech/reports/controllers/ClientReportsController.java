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
import pl.lodz.p.it.bakertech.reports.dto.NumberValueDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;
import pl.lodz.p.it.bakertech.reports.dto.client.ClientDeviceReportInfoDTO;
import pl.lodz.p.it.bakertech.reports.services.ClientReportsService;

@RestController
@RequestMapping("/reports/client")
@RequiredArgsConstructor
@PreAuthorize("hasRole(@Roles.CLIENT)")
public class ClientReportsController {
    private final ClientReportsService clientReportsService;

    @GetMapping("/amount-of-warranty-devices")
    public ResponseEntity<NumberValueDTO> getAmountOfDevicesUnderWarrantyByMonth(@RequestParam(name = "month", required = false) Integer month,
                                                                                 @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(clientReportsService.getDevicesUnderWarrantyByMonth(month, year));
    }

    @GetMapping("/amount-of-executed-orders")
    public ResponseEntity<NumberValueDTO> getAmountOfOrdersForClient(@RequestParam(name = "month", required = false) Integer month,
                                                                     @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(clientReportsService.getOrdersInMonthForClient(month, year));
    }

    @GetMapping("/devices-serviced-for-client")
    public ResponseEntity<Page<ClientDeviceReportInfoDTO>> getServicedDevicesForClient(@PageableDefault Pageable page,
                                                                                       @RequestParam(name = "month", required = false) Integer month,
                                                                                       @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(clientReportsService.getServicedDevicesForClient(month, year, page));
    }

    @GetMapping("/percentage-of-orders")
    public ResponseEntity<PercentageOfOrdersDTO> getPercentageDataForExecutedOrdersForClient(@RequestParam(name = "month", required = false) Integer month,
                                                                                                @RequestParam(name = "year", required = false) Integer year) {
        return ResponseEntity.ok(clientReportsService.findPercentageOfOrdersByTypeAndUsername(month, year));
    }
}
