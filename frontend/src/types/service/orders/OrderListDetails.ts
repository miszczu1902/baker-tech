import { OrderType } from "./OrderType";
import { OrderStatus } from "./OrderStatus";

export interface OrderListDetails {
  id: number;
  licenseId: string;
  client: string;
  orderType: OrderType;
  status: OrderStatus;
  dateOfOrderExecution: string;
  delayed: boolean;
}
