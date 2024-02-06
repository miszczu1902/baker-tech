import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import React, { useEffect, useState } from "react";
import { Box, Table, TableBody, TableCell, TableRow } from "@mui/material";
import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import { OrdersInPeriodType } from "../../../types/reports/OrdersInPeriodType";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import Typography from "@mui/material/Typography";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const OrdersInPeriod = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const [ordersInPeriod, setOrdersInPeriod] = useState<OrdersInPeriodType>();

  const getOrdersInPeriod = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.ADMIN_ORDERS_IN_PERIOD,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  const success = (arg: any) => {
    setOrdersInPeriod(arg);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<OrdersInPeriodType>(getOrdersInPeriod())
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(false));
      });
  }, [date]);

  return (
    <Box className="param-content">
      <Typography className="param-content-title">
        {t("reports.admin.ordersStatuses")}
      </Typography>
      <Table>
        <TableBody>
          <TableRow>
            <TableCell></TableCell>
          </TableRow>
          <TableRow key={1}>
            <TableCell className="param-content-item">
              {t(`orders.open`)}
            </TableCell>
            <TableCell className="param-content-item">
              {ordersInPeriod?.openedOrders}
            </TableCell>
          </TableRow>
          <TableRow key={2}>
            <TableCell className="param-content-item">
              {t(`orders.in_progress`)}
            </TableCell>
            <TableCell className="param-content-item">
              {ordersInPeriod?.ordersInProgress}
            </TableCell>
          </TableRow>
          <TableRow key={3}>
            <TableCell className="param-content-item">
              {t(`orders.for_settlement`)}
            </TableCell>
            <TableCell className="param-content-item">
              {ordersInPeriod?.ordersToSettlement}
            </TableCell>
          </TableRow>
          <TableRow key={4}>
            <TableCell className="param-content-item">
              {t(`orders.closed`)}
            </TableCell>
            <TableCell className="param-content-item">
              {ordersInPeriod?.closedOrders}
            </TableCell>
          </TableRow>
          <TableRow key={5}>
            <TableCell className="param-content-item">
              {t(`orders.delayedOrders`)}
            </TableCell>
            <TableCell className="param-content-item">
              {ordersInPeriod?.delayedOrders}
            </TableCell>
          </TableRow>
        </TableBody>
      </Table>
    </Box>
  );
};
export default OrdersInPeriod;
