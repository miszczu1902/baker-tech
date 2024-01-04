package pl.lodz.p.it.bakertech.reports.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import pl.lodz.p.it.bakertech.reports.dto.NumberValueDTO;
import pl.lodz.p.it.bakertech.reports.dto.client.ClientDeviceReportInfoDTO;

public interface ClientReportsService {
    NumberValueDTO getDevicesUnderWarrantyByMonth(Integer month, Integer year);

    NumberValueDTO getOrdersInMonthForClient(Integer month, Integer year);

    Page<ClientDeviceReportInfoDTO> getServicedDevicesForClient(Integer month, Integer year, Pageable pageable);
}
