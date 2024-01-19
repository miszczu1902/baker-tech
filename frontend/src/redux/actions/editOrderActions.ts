import { CLOSE_ORDER, SEND_ORDER_TO_SETTLEMENT, SET_DEVICES_FOR_ORDER } from "./actions";
import { Settlement } from "../../types/service/orders/Settlement";
import { Close } from "../../types/service/orders/Close";

export const setDevicesForOrder = (data: number[]) => {
  return {
    type: SET_DEVICES_FOR_ORDER,
    payload: data,
  };
};

export const sendOrderToSettlement = (data: Settlement) => {
  return {
    type: SEND_ORDER_TO_SETTLEMENT,
    payload: data,
  };
};

export const closeOrder = (data: Close) => {
  return {
    type: CLOSE_ORDER,
    payload: data,
  };
};
