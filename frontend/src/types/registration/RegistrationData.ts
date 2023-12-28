import {Languages} from "../Languages";
import {PersonalData} from "../accounts/PersonalData";
import {Address} from "../accounts/Address";
import {BillingDetails} from "../accounts/BillingDetails";

export interface RegistrationData {
    username?: string;
    password?: string;
    email?: string;
    companyName?: string;
    defaultLanguage?: Languages;
    personalData?: PersonalData;
    address?: Address;
    billingDetails?: BillingDetails;
}