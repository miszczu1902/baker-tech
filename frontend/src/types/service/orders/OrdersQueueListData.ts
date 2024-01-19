import { OrderType } from "./OrderType";

export interface OrdersQueueListData {
  id: number;
  client: string;
  address: string;
  dateOfOrderExecution: string;
  orderType: OrderType;
  delayed: boolean;
}
