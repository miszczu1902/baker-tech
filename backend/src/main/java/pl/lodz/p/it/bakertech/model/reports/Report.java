package pl.lodz.p.it.bakertech.model.reports;

import jakarta.persistence.*;
import lombok.*;
import pl.lodz.p.it.bakertech.model.AbstractEntityWithId;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.validation.constraint.reports.ReportTitle;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "report", indexes = {
        @Index(name = "report_access_level_id", columnList = "access_level_id")
})
public class Report extends AbstractEntityWithId {
    @ManyToOne
    @JoinColumn(name = "access_level_id", referencedColumnName = "id")
    private AccessLevel accessLevel;

    @Column(name = "report_start_date", nullable = false, updatable = false)
    private LocalDate startDateOfReportPeriod;

    @Column(name = "report_end_date", nullable = false, updatable = false)
    private LocalDate endDateOfReportPeriod;

    @ReportTitle
    @Column(name = "report_title", nullable = false, updatable = false)
    private String reportTitle;

    @ElementCollection
    @CollectionTable(name = "report_number_data", joinColumns = @JoinColumn(name = "report_id"))
    @MapKeyColumn(name = "report_number_data_key")
    @Column(name = "report_number_data_value")
    private Map<String, BigDecimal> numberValues = new HashMap<>();

    @ElementCollection
    @CollectionTable(name = "report_text_data", joinColumns = @JoinColumn(name = "report_id"))
    @MapKeyColumn(name = "report_text_data_key")
    @Column(name = "report_text_data_value")
    private Map<String, String> textValues = new HashMap<>();
}