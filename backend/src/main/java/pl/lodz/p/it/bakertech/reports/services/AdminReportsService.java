package pl.lodz.p.it.bakertech.reports.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import pl.lodz.p.it.bakertech.reports.dto.TextWithNumberReportDataDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.OrdersReportInfoDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;

public interface AdminReportsService {
    PercentageOfOrdersDTO findPercentageOfOrdersByType(Integer month, Integer year);

    Page<TextWithNumberReportDataDTO> ordersByServicemanInMonth(Integer month, Integer year, Pageable pageable);

    OrdersReportInfoDTO getOrders(Integer month, Integer year);
}
