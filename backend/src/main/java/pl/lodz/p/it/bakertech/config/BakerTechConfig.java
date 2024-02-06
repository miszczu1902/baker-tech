package pl.lodz.p.it.bakertech.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.math.MathContext;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Component
public class BakerTechConfig {
    public static DateTimeFormatter DATE_TIME_FORMATTER;
    public static ZoneId TIMEZONE;
    public static String APP_URI;
    public static final MathContext ROUNDING_PRECISION = new MathContext(2);

    @Autowired
    public BakerTechConfig(
            @Value("${bakertech.datetime.format}") String dateTimeFormatter,
            @Value("${bakertech.timezone}") String timezone,
            @Value("${bakertech.frontend.url}") String authUri
    ) {
        DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern(dateTimeFormatter);
        TIMEZONE = ZoneId.of(timezone);
        APP_URI = authUri;
    }
}
