package pl.lodz.p.it.bakertech.config;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;

@Component
public class BakerTechConfig {
    @Value("${bakertech.datetime.format}")
    private String dateTimeFormat;

    public static DateTimeFormatter DATE_TIME_FORMATTER;

    @PostConstruct
    public void init() {
        DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern(dateTimeFormat);
    }
}
