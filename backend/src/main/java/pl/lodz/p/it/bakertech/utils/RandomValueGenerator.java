package pl.lodz.p.it.bakertech.utils;

import org.apache.commons.lang3.RandomStringUtils;

public class RandomValueGenerator {
    public static String generateRandomPassword() {
        return RandomStringUtils.randomAlphanumeric(16, 25);
    }

    public static String generateConfirmationToken() {
        return RandomStringUtils.randomAlphanumeric(10);
    }
}
