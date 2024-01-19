import {
  SET_REPORT_PERIOD_MONTH,
  SET_REPORT_PERIOD_YEAR,
} from "../actions/actions";

const initialState = {
  year: undefined,
  month: undefined,
};

const reportReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case SET_REPORT_PERIOD_YEAR:
      return {
        ...state,
        year: action.payload,
      };
    case SET_REPORT_PERIOD_MONTH:
      return {
        ...state,
        month: action.payload,
      };
    default:
      return state;
  }
};

export default reportReducer;
