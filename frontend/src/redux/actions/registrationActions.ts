import { RegistrationData } from "../../types/registration/RegistrationData";
import { Address } from "../../types/accounts/Address";
import { BillingDetails } from "../../types/accounts/BillingDetails";
import { PersonalData } from "../../types/accounts/PersonalData";
import {
  UPDATE_ADDRESS,
  UPDATE_BILLING_DETAILS,
  UPDATE_PERSONAL_DATA,
  UPDATE_REGISTRATION_DATA,
} from "./actions";

export const updateBasicRegistrationData = (data: RegistrationData) => {
  return {
    type: UPDATE_REGISTRATION_DATA,
    payload: data,
  };
};

export const updateAddressDuringRegistration = (data: Address) => {
  return {
    type: UPDATE_ADDRESS,
    payload: data,
  };
};

export const updateBillingDetailsDuringRegistration = (
  data: BillingDetails,
) => {
  return {
    type: UPDATE_BILLING_DETAILS,
    payload: data,
  };
};

export const updatePersonalDataDuringRegistration = (data: PersonalData) => {
  return {
    type: UPDATE_PERSONAL_DATA,
    payload: data,
  };
};
