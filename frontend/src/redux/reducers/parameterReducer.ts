import { SET_SERVICE_PARAMETER_VALUE } from "../actions/actions";

const initialState = {
  value: undefined,
};

const parameterReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case SET_SERVICE_PARAMETER_VALUE:
      return {
        ...state,
        value: action.payload,
      };
    default:
      return state;
  }
};

export default parameterReducer;
