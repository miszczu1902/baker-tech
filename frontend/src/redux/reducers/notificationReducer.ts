import { SET_OPEN_ALERT, SET_OPEN_CONFIRM } from "../actions/actions";

const initialState =  {
  isOpen: false,
  isOpenAlert: false
}

const notificationReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case SET_OPEN_CONFIRM:
      return {
        ...state,
        isOpen: action.payload,
      };
    case SET_OPEN_ALERT:
      return {
        ...state,
        isOpenAlert: action.payload,
      };
    default:
      return state;
  }
};

export default notificationReducer;