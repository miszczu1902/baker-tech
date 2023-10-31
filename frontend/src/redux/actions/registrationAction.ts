import {RegistrationData} from "../../types/registration/RegistrationData";
import {RegistrationAddress} from "../../types/registration/RegistrationAddress";
import {RegistrationBillingDetails} from "../../types/registration/RegistrationBillingDetails";
import {RegistrationPersonalData} from "../../types/registration/RegistrationPersonalData";

export const updateBasicRegistrationData = (data: RegistrationData) => {
    return {
        type: 'UPDATE_REGISTRATION_DATA',
        payload: data,
    };
};

export const updateAddressDuringRegistration = (data: RegistrationAddress) => {
    return {
        type: 'UPDATE_ADDRESS',
        payload: data,
    };
};

export const updateBillingDetailsDuringRegistration = (data: RegistrationBillingDetails) => {
    return {
        type: 'UPDATE_BILLING_DETAILS',
        payload: data,
    };
};

export const updatePersonalDataDuringRegistration = (data: RegistrationPersonalData) => {
    return {
        type: 'UPDATE_PERSONAL_DATA',
        payload: data,
    };
};