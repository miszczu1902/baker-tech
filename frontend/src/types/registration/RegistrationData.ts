import {RegistrationPersonalData} from "./RegistrationPersonalData";
import {RegistrationAddress} from "./RegistrationAddress";
import {RegistrationBillingDetails} from "./RegistrationBillingDetails";
import {Languages} from "../Languages";

export interface RegistrationData {
    username?: string;
    password?: string;
    email?: string;
    companyName?: string;
    defaultLanguage?: Languages;
    personalData?: RegistrationPersonalData;
    address?: RegistrationAddress;
    billingDetails?: RegistrationBillingDetails;
}