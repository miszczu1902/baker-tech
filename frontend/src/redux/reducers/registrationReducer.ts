import { RegistrationData } from "../../types/registration/RegistrationData";
import { Languages } from "../../types/Languages";
import {
  UPDATE_ADDRESS,
  UPDATE_BILLING_DETAILS,
  UPDATE_PERSONAL_DATA,
  UPDATE_REGISTRATION_DATA,
} from "../actions/actions";

const initialState: RegistrationData = {
  username: undefined,
  password: undefined,
  email: undefined,
  defaultLanguage:
    (localStorage.getItem("language") as Languages) ||
    (navigator.language as Languages),
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
    case UPDATE_REGISTRATION_DATA:
      return {
        ...state,
        ...action.payload,
      };
    case UPDATE_ADDRESS:
      return {
        ...state,
        address: {
          ...state.address,
          ...action.payload,
        },
      };
    case UPDATE_BILLING_DETAILS:
      return {
        ...state,
        billingDetails: {
          ...state.billingDetails,
          ...action.payload,
        },
      };
    case UPDATE_PERSONAL_DATA:
      return {
        ...state,
        personalData: {
          ...state.personalData,
          ...action.payload,
        },
      };
    default:
      return state;
  }
};

export default registrationReducer;
