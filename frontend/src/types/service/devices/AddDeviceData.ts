import { DeviceCategory } from "./DeviceCategory";

export interface AddDeviceData {
  deviceName?: string;
  brand?: string;
  serialNumber?: string;
  warrantyEnded?: boolean;
  category?: DeviceCategory;
}
