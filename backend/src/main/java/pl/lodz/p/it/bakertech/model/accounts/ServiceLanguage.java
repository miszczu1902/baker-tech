package pl.lodz.p.it.bakertech.model.accounts;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Arrays;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public enum ServiceLanguage {
    POLISH("PL"), ENGLISH("EN");

    private String value;

    public ServiceLanguage fromValue(String language) {
        return Arrays.stream(ServiceLanguage.values())
                .filter(lang -> lang.getValue().equals(language))
                .findFirst().orElse(ENGLISH);
    }
}
