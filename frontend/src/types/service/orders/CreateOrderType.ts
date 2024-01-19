import { NextOrderData } from "./NextOrderData";
import { OrderType } from "./OrderType";

export interface CreateOrderType {
  client?: string;
  description?: string;
  orderType?: OrderType;
  nextOrderData?: NextOrderData;
}
