import { DeviceCategory } from "../service/devices/DeviceCategory";

export interface ClientDevicesData {
  brand : string;
  category: DeviceCategory;
  deviceName: string;
  serialNumber: string;
}