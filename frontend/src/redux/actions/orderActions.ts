import { SET_CLIENT_FOR_ORDER } from "./actions";

export const setClientForOrder = (data: string) => {
  return {
    type: SET_CLIENT_FOR_ORDER,
    payload: data,
  };
};
