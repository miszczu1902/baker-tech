package pl.lodz.p.it.bakertech.utils;

import org.apache.commons.lang3.RandomStringUtils;

public class RandomValueGenerator {
    public static String generateRandomPassword() {
        return "%s%s".formatted(RandomStringUtils.randomAlphanumeric(16, 25), RandomStringUtils.random(1,  "!@#$%^&*()_-+=<>?"));
    }

    public static String generateConfirmationToken() {
        return RandomStringUtils.randomAlphanumeric(10);
    }
}
