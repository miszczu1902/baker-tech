import { OrderType } from "./OrderType";
import { OrderStatus } from "./OrderStatus";
import { Conservation } from "./Conservation";
import { WarrantyRepair } from "./WarrantyRepair";
import { OrderDataType } from "./OrderDataType";

export interface OrderDetails {
  id: number;
  version: number;
  licenseId: string;
  client: string;
  status: OrderStatus;
  orderType: OrderType;
  orderData: OrderDataType;
  conservation: Conservation;
  warrantyRepair: WarrantyRepair;
  delayed: boolean;
  inOrderQueue: boolean;
}
