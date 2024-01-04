package pl.lodz.p.it.bakertech.reports.dto.admin;

import java.math.BigDecimal;

public record PercentageOfOrdersDTO(BigDecimal nonWarrantyRepair,
                                    BigDecimal warrantyRepair,
                                    BigDecimal conservation) {
}
