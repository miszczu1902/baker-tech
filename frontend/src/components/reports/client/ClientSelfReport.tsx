import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import React, { useEffect, useState } from "react";
import { NumberValue } from "../../../types/reports/NumberValue";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { Box, Table, TableBody, TableCell, TableRow } from "@mui/material";
import Typography from "@mui/material/Typography";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const ClientSelfReport = () => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const requestService = RequestService.getInstance();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const [warrantyDevices, setWarrantyDevices] = useState<NumberValue>();
  const [executedOrders, setExecutedOrders] = useState<NumberValue>();

  const getWarrantyDevicesRequest = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.CLIENT_WARRANTY_DEVICES,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  const getExecutedOrdersRequest = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.CLIENT_EXECUTED_ORDERS,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  const successWarrantyDevices = (arg: any) => {
    setWarrantyDevices(arg);
  };

  const successExecutedOrders = (arg: any) => {
    setExecutedOrders(arg);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<NumberValue>(getWarrantyDevicesRequest())
      .then(successWarrantyDevices)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(false));
      });
    requestService
      .sendRequestAndGetResponse<NumberValue>(getExecutedOrdersRequest())
      .then(successExecutedOrders)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [date]);

  return (
    <Box className="param-content">
      <Typography className="param-content-title">
        {t("reports.client.reportTitle")}
      </Typography>
      <Table>
        <TableBody>
          <TableRow key={1}>
            <TableCell className="param-content-item">
              {t(`reports.client.warrantyDevices`)}
            </TableCell>
            <TableCell className="param-content-item">
              {warrantyDevices?.value}
            </TableCell>
          </TableRow>
          <TableRow key={2}>
            <TableCell className="param-content-item">
              {t(`reports.client.executedOrders`)}
            </TableCell>
            <TableCell className="param-content-item">
              {executedOrders?.value}
            </TableCell>
          </TableRow>
        </TableBody>
      </Table>
    </Box>
  );
};
export default ClientSelfReport;
