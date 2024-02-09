package pl.lodz.p.it.bakertech.validation;

import org.springframework.stereotype.Component;

@Component
public class Messages {
    public static final String errorUnauthorized = "error.unauthorized";
    public static final String errorForbidden = "error.forbidden";
    public static final String internalServerError = "error.internalServer";
    public static final String contentChanged = "error.contentChanged";
    public static final String validationViolation = "validation.violation";
    public static final String badRequest = "error.badRequest";
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
    public static final String invalidLicense = "validation.invalid.license";
    public static final String invalidOrderDuration = "validation.invalid.duration";
    public static final String invalidOrderDescription = "validation.invalid.orderDescription";
    public static final String invalidDeviceName = "validation.invalid.deviceName";
    public static final String invalidSerialNumber = "validation.invalid.serialNumber";
    public static final String invalidServiceParameterValue = "validation.invalid.param";
    public static final String invalidReportTitle = "validation.invalid.reportTitle";
    public static final String invalidBrandName = "validation.invalid.brandName";
    public static final String invalidTotalCost = "validation.invalid.totalCost";
    public static final String invalidConfirmationToken = "validation.invalid.confirmationToken";
    public static final String invalidDatePeriod = "validation.invalid.datePeriod";

    /* Operations */
    public static final String cannotResetPassword = "cannot.resetPassword";
    public static final String cannotChangeStatusSelf = "cannot.change.statusSelf";
    public static final String cannotChangeAccessLevelsSelf = "cannot.change.accessLevelsSelf";
    public static final String cannotAssignAccessLevels = "cannot.change.accessLevelsSelf";
    public static final String cannotRemoveOneAccessLevel = "cannot.remove.oneAccessLevel";
    public static final String cannotChangeWarranty = "cannot.change.warranty";
    public static final String cannotAssignNonWarrantyDevice = "cannot.assign.nonWarrantyDevice";
    public static final String cannotAssignMoreWarrantyDevice = "cannot.assign.moreWarrantyDevice";
    public static final String cannotChangeOrder = "cannot.change.order";
    public static final String cannotChangeOrderNotSelf = "cannot.change.orderNotSelf";
    public static final String cannotSettleOrder = "cannot.settle.order";
}
