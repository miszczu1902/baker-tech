import {RegistrationData} from "../../types/registration/RegistrationData";
import {Languages} from "../../types/Languages";

const initialState: RegistrationData = {
    username: undefined,
    password: undefined,
    email: undefined,
    defaultLanguage: Languages.pl,
    personalData: {
        firstname: undefined,
        lastname: undefined,
        phoneNumber: undefined,
    },
    address: {
        street: undefined,
        streetNumber: undefined,
        city: undefined,
        postalCode: undefined,
    },
    billingDetails: {
        nip: undefined,
        regon: undefined,
    },
};

const registrationReducer = (state = initialState, action: any) => {
    switch (action.type) {
        case 'UPDATE_REGISTRATION_DATA':
            return {
                ...state,
                ...action.payload,
            };
        case 'UPDATE_ADDRESS':
            return {
                ...state.address,
                ...action.payload,
            }
        case 'UPDATE_BILLING_DETAILS':
            return {
                ...state.billingDetails,
                ...action.payload,
            }
        case 'UPDATE_PERSONAL_DATA':
            return {
                ...state.personalData,
                ...action.payload,
            }
        default:
            return state;
    }
};

export default registrationReducer;