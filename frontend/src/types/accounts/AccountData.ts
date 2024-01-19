import { PersonalData } from "./PersonalData";
import { Address } from "./Address";
import { BillingDetails } from "./BillingDetails";

export interface AccountData {
  id?: number;
  username?: string;
  email?: string;
  isActive?: boolean;
  personalData?: PersonalData;
  address?: Address;
  billingDetails?: BillingDetails;
  accessLevels?: string[];
  licenseId?: string;
  version?: number;
}
