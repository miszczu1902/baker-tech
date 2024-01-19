import { SET_ORDER_IN_EDITION } from "../actions/actions";

const isOrderInEditionState = {
  orderInEdition: false
};

const orderStateReducer = (state = isOrderInEditionState, action: any) => {
  switch (action.type) {
    case SET_ORDER_IN_EDITION:
      return {
        ...state,
        orderInEdition: action.payload
      };
    default:
      return state;
  }
};

export default orderStateReducer;