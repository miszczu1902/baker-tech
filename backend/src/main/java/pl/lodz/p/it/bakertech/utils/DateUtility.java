package pl.lodz.p.it.bakertech.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import static pl.lodz.p.it.bakertech.config.BakerTechConfig.*;

public class DateUtility {
    public static LocalDateTime nowWithoutTimestamp(boolean startOfDay) {
        return startOfDay ? LocalDate.now(TIMEZONE).atStartOfDay() : LocalDate.now(TIMEZONE).atTime(LocalTime.MAX);
    }

    public static LocalDateTime nowWithTimestamp() {
        return LocalDateTime.parse(LocalDateTime.now(TIMEZONE).format(DATE_TIME_FORMATTER));
    }

    public static LocalDateTime parseWithoutTimestamp(LocalDateTime dateTime, boolean startOfDay) {
        return startOfDay ? dateTime.toLocalDate().atStartOfDay() : dateTime;
    }
}
