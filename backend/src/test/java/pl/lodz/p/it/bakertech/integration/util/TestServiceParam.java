package pl.lodz.p.it.bakertech.integration.util;

import lombok.Builder;
import lombok.Data;
import lombok.experimental.Accessors;
import pl.lodz.p.it.bakertech.model.service.parameters.ServiceParameterType;
import pl.lodz.p.it.bakertech.validation.etag.ETagField;

import java.math.BigDecimal;

@Data
@Builder
@Accessors(fluent = true)
public class TestServiceParam {
    private Long id;

    @ETagField
    private Long version;

    @ETagField
    private BigDecimal value;

    private ServiceParameterType serviceParameterType;

    public static TestServiceParam UNIT_COST_OF_WORKING_HOUR = builder()
            .id(0L)
            .version(0L)
            .value(new BigDecimal("100.00"))
            .serviceParameterType(ServiceParameterType.UNIT_COST_OF_WORKING_HOUR)
            .build();

    public static TestServiceParam CUT_OFF_DATE_PERIOD = builder()
            .id(-1L)
            .version(0L)
            .value(new BigDecimal("3.00"))
            .serviceParameterType(ServiceParameterType.CUT_OFF_DATE_PERIOD)
            .build();
}
