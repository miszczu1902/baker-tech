import { SET_OPEN_ALERT, SET_OPEN_CONFIRM } from "./actions";

export const setOpenConfirm = (data: boolean) => {
  return {
    type: SET_OPEN_CONFIRM,
    payload: data
  };
};

export const setOpenAlert = (data: boolean) => {
  return {
    type: SET_OPEN_ALERT,
    payload: data
  };
};