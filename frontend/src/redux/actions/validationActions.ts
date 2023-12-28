import {
    SET_FIRST_PAGE_REGISTRATION_STATUS,
    SET_SECOND_PAGE_REGISTRATION_STATUS,
    SET_THIRD_PAGE_REGISTRATION_STATUS
} from "./actions";
import {RegistrationValidationPages} from "../../types/registration/RegistrationValidationPages";

export const setFirstPageRegistrationStatus = (data: RegistrationValidationPages) => {
    return {
        type: SET_FIRST_PAGE_REGISTRATION_STATUS,
        payload: data
    };
}

export const setSecondPageRegistrationStatus = (data: RegistrationValidationPages) => {
    return {
        type: SET_SECOND_PAGE_REGISTRATION_STATUS,
        payload: data
    };
}

export const setThirdPageRegistrationStatus = (data: RegistrationValidationPages) => {
    return {
        type: SET_THIRD_PAGE_REGISTRATION_STATUS,
        payload: data
    };
}