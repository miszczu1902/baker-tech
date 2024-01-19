import { SET_SERVICE_PARAMETER_VALUE } from "./actions";

export const setNewServiceParameterValue = (data: number) => {
  return {
    type: SET_SERVICE_PARAMETER_VALUE,
    payload: data,
  };
};
