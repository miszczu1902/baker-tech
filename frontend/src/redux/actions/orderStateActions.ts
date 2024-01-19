import { SET_ORDER_IN_EDITION } from "./actions";

export const changeOrderState = (data: boolean) => {
  return {
    type: SET_ORDER_IN_EDITION,
    payload: data,
  };
};
