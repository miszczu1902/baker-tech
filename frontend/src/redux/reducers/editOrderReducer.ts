import { CLOSE_ORDER, SEND_ORDER_TO_SETTLEMENT, SET_DEVICES_FOR_ORDER } from "../actions/actions";
import { EditOrderData } from "../../types/service/orders/EditOrderData";

const initialState: EditOrderData = {
  forSettlement: {
    duration: undefined,
    devices: [],
    reportNextAutomatically: undefined
  },
  forClose: {
    totalCost: undefined
  }
};

const editOrderReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case SET_DEVICES_FOR_ORDER:
      return {
        ...state,
        forSettlement: {
          ...state.forSettlement,
          devices: action.payload
        }
      };
    case SEND_ORDER_TO_SETTLEMENT:
      return {
        ...state,
        forSettlement: {
          ...state.forSettlement,
          ...action.payload
        }
      };
    case CLOSE_ORDER:
      return {
        ...state,
        forClose: {
          ...state.forClose,
          ...action.payload
        }
      };
    default:
      return state;
  }
};

export default editOrderReducer;
