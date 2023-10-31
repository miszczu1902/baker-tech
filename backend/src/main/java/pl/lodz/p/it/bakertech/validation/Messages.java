package pl.lodz.p.it.bakertech.validation;

import org.springframework.stereotype.Component;

@Component
public class Messages {
    public static final String errorUnauthorized = "error.unauthorized";
    public static final String errorForbidden = "error.forbidden";
    public static final String internalServerError = "error.internalServer";
    public static final String validationViolation = "validation.violation";
    public static final String objectNotFound = "object.notFound";
    public static final String objectNotUnique = "object.notUnique";

    /* Validations */
    public static final String invalidUsername = "validation.invalid.username";
    public static final String incorrectPassword = "validation.invalid.password";
    public static final String invalidEmail = "validation.invalid.email";
    public static final String invalidCompanyName = "validation.invalid.companyName";
    public static final String invalidPostalCode = "validation.invalid.postalCode";
    public static final String invalidCity = "validation.invalid.city";
    public static final String invalidStreet = "validation.invalid.street";
    public static final String invalidStreetNumber = "validation.invalid.streetNumber";
    public static final String invalidPhoneNumber = "validation.invalid.phoneNumber";
    public static final String invalidNip = "validation.invalid.nip";
    public static final String invalidRegon = "validation.invalid.regon";
    public static final String invalidFirstname = "validation.invalid.firstname";
    public static final String invalidLastname = "validation.invalid.lastname";
    public static final String invalidLanguage = "validation.invalid.language";
    public static final String invalidLicense = "validation.invalid.license";
}
