import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import React, { useEffect, useState } from "react";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import {
  Box,
  Table,
  TableBody,
  TableCell,
  TableRow,
  Typography,
} from "@mui/material";
import { NumberValue } from "../../../types/reports/NumberValue";
import { TextWithNumberReportData } from "../../../types/reports/TextWithNumberReportData";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const ServicemanSelfReport = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const [avgTime, setAvgTime] = useState<NumberValue>();
  const [amountOfExecutedOrders, setAmountOfExecutedOrders] =
    useState<TextWithNumberReportData>();
  const [mostCommonType, setMostCommonType] =
    useState<TextWithNumberReportData>();

  const getAvgTimeRequest = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.SERVICEMAN_AVERAGE_TIME,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  const getAmountOfExecutedOrdersRequest = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.SERVICEMAN_IN_TIME,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  const getMostCommonTypeRequest = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.SERVICEMAN_MOST_TYPE,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  const successAvgTime = (arg: any) => {
    setAvgTime(arg);
  };

  const successExecutedOrders = (arg: any) => {
    setAmountOfExecutedOrders(arg);
  };

  const successMostCommonType = (arg: any) => {
    setMostCommonType(arg);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<NumberValue>(getAvgTimeRequest())
      .then(successAvgTime)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
    requestService
      .sendRequestAndGetResponse<TextWithNumberReportData>(
        getAmountOfExecutedOrdersRequest(),
      )
      .then(successExecutedOrders)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
    requestService
      .sendRequestAndGetResponse<TextWithNumberReportData>(
        getMostCommonTypeRequest(),
      )
      .then(successMostCommonType)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [date]);

  return (
    <Box className="param-content">
      <Typography className="param-content-title">
        {t("reports.serviceman.reportTitle")}
      </Typography>
      <Table>
        <TableBody>
          <TableRow key={1}>
            <TableCell className="param-content-item">
              {t(`reports.serviceman.avgTime`)}
            </TableCell>
            <TableCell className="param-content-item">
              {avgTime?.value}
            </TableCell>
          </TableRow>
          <TableRow key={2}>
            <TableCell className="param-content-item">
              {t(`reports.serviceman.exec`)}
            </TableCell>
            <TableCell className="param-content-item">
              {amountOfExecutedOrders?.value}
            </TableCell>
          </TableRow>
          <TableRow key={3}>
            <TableCell className="param-content-item">
              {t(`reports.serviceman.type`)}
            </TableCell>
            <TableCell className="param-content-item">
              {t(`devices.${mostCommonType?.content.toLowerCase()}`) +
                " x" +
                mostCommonType?.value}
            </TableCell>
          </TableRow>
        </TableBody>
      </Table>
    </Box>
  );
};
export default ServicemanSelfReport;
