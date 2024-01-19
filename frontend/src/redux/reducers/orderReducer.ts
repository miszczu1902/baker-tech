import { SET_CLIENT_FOR_ORDER } from "../actions/actions";

const initialState = {
  username: "buttons.select",
};

const orderReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case SET_CLIENT_FOR_ORDER:
      return {
        ...state,
        username: action.payload,
      };
    default:
      return state;
  }
};

export default orderReducer;
