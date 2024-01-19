import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import ContainerSelect from "../containers/ContainerSelect";
import { useTranslation } from "react-i18next";
import { RequestData, RequestMethod } from "../../api/RequestData";
import { ApiEndpoints } from "../../api/ApiEndpoints";
import React, { useEffect, useState } from "react";
import { RequestService } from "../../api/RequestService";
import { Dates } from "../../types/reports/Dates";
import {
  setPeriodReportMonth,
  setPeriodReportYear,
} from "../../redux/actions/reportActions";
import Typography from "@mui/material/Typography";
import { Box } from "@mui/material";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../redux/actions/notificationActions";

const ReportDates = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const dispatch = useDispatch();
  const [availableYears, setAvailableYears] = useState<string[]>([]);
  const [availableMonths, setAvailableMonths] = useState<string[]>([]);

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.REPORT_DATES,
    };
  };

  const handleYearChange = (event: React.ChangeEvent<{ value: unknown }>) => {
    const updatedValue =
      event.target.value === date.year ? null : event.target.value;
    dispatch(setPeriodReportYear(updatedValue as number));
  };

  const handleMonthChange = (event: React.ChangeEvent<{ value: unknown }>) => {
    const updatedValue =
      event.target.value === date.month ? null : event.target.value;
    dispatch(setPeriodReportMonth(updatedValue as number));
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<Dates>(getRequestData())
      .then((response) => {
        let years: string[] = [];
        let months: string[] = [];

        response.dates?.forEach((row) => {
          let split = row.split("-") as string[];

          if (!years.includes(split[0])) {
            years = [...years, split[0].toString()];
          }
          if (!months.includes(split[1])) {
            months = [...months, split[1].toString()];
          }
        });

        setAvailableYears(years);
        setAvailableMonths(months);
      })
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [date]);

  return (
    <Box flexGrow={1} className="data-select">
      <Box className="row">
        <Box flexGrow={1}>
          <Typography className="param-content-title">
            {t("reports.year")}
          </Typography>
          <ContainerSelect
            values={availableYears}
            onChange={handleYearChange}
            renderValue={date.year}
          />
        </Box>
        <Box flexGrow={1}>
          <Typography className="param-content-title">
            {t("reports.month")}
          </Typography>
          <ContainerSelect
            values={availableMonths}
            onChange={handleMonthChange}
            renderValue={date.month}
          />
        </Box>
      </Box>
    </Box>
  );
};
export default ReportDates;
