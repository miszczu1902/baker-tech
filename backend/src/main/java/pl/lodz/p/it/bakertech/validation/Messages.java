package pl.lodz.p.it.bakertech.validation;

import org.springframework.stereotype.Component;

@Component
public class Messages {
    public static final String errorUnauthorized = "error.unauthorized";
    public static final String errorForbidden = "error.forbidden";
    public static final String internalServerError = "internal.server.error";
    public static final String keycloakError = "keycloak.error";
    public static final String validationViolation = "validation.violation";
    public static final String objectNotFound = "object.notFound";
    public static final String objectNotUnique = "object.notUnique";

    /* Validations */
    public static final String invalidUsername = "validation.username.invalid";
    public static final String incorrectPassword = "validation.username.incorrect";
    public static final String invalidEmail = "validation.email.invalid";
    public static final String invalidClientName = "validation.clientName.invalid";
    public static final String invalidPostalCode = "validation.postalCode.invalid";
    public static final String invalidCity = "validation.city.invalid";
    public static final String invalidStreet = "validation.street.invalid";
    public static final String invalidStreetNumber = "validation.streetNumber.invalid";
    public static final String invalidPhoneNumber = "validation.phoneNumber.invalid";
    public static final String invalidNip = "validation.nip.invalid";
    public static final String invalidRegon = "validation.regon.invalid";
    public static final String invalidFirstname = "validation.firstname.invalid";
    public static final String invalidLastname = "validation.lastname.invalid";
    public static final String invalidLanguage = "validation.language.invalid";
    public static final String invalidLicense = "validation.license.invalid";
}
