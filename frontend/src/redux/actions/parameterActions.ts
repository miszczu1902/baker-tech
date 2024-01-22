import { SET_SERVICE_PARAMETER_VALUE } from "./actions";

export const setNewServiceParameterValue = (data: number | undefined) => {
  return {
    type: SET_SERVICE_PARAMETER_VALUE,
    payload: data,
  };
};
