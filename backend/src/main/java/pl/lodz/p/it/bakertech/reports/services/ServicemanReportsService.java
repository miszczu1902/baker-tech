package pl.lodz.p.it.bakertech.reports.services;

import pl.lodz.p.it.bakertech.reports.dto.TextWithNumberReportDataDTO;
import pl.lodz.p.it.bakertech.reports.dto.NumberValueDTO;
import pl.lodz.p.it.bakertech.reports.dto.admin.PercentageOfOrdersDTO;

public interface ServicemanReportsService {
    NumberValueDTO getAverageOrderTimeExecution(Integer month, Integer year);

    TextWithNumberReportDataDTO getAmountOfOrdersExecutedByServiceman(Integer month, Integer year);

    TextWithNumberReportDataDTO getTheMostFrequentlyRepairedTypeOfDevicesInService(Integer month, Integer year);

    PercentageOfOrdersDTO findPercentageOfOrdersByTypeAndUsername(Integer month, Integer year);
}
