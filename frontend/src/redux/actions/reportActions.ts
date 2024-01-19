import { SET_REPORT_PERIOD_MONTH, SET_REPORT_PERIOD_YEAR } from "./actions";

export const setPeriodReportYear = (data: number) => {
  return {
    type: SET_REPORT_PERIOD_YEAR,
    payload: data,
  };
};

export const setPeriodReportMonth = (data: number) => {
  return {
    type: SET_REPORT_PERIOD_MONTH,
    payload: data,
  };
};
