import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import { useNavigate } from "react-router-dom";
import React, { useEffect, useState } from "react";
import { DeviceData } from "../../../types/service/devices/DeviceData";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { DEFAULT_PAGE_SIZE } from "../../../utils/consts";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { ListData } from "../../../types/ListData";
import ContainerRow, { InputType } from "../../containers/ContainerRow";
import {
  Checkbox,
  FormControlLabel,
  Pagination,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@mui/material";
import LoopIcon from "@mui/icons-material/Loop";
import NotificationHandler from "../../response/NotificationHandler";
import { OrderListDetails } from "../../../types/service/orders/OrderListDetails";
import { OrderStatus } from "../../../types/service/orders/OrderStatus";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { Roles } from "../../../security/Roles";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const OrdersList = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const navigate = useNavigate();
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as Roles;
  const currentUser = useSelector(
    (state: RootState) => state.currentUser,
  ).currentUser;
  const dispatch = useDispatch();
  const [orders, setOrders] = useState<OrderListDetails[]>();
  const [sortBy, setSortBy] = useState("");
  const [filter, setFilter] = useState<string>("");
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>();
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);
  const [orderStatus, setOrderStatus] = useState<string>("");
  const [assignedToServiceman, setAssignedToServiceman] =
    useState<boolean>(false);

  const getOrdersData = (): RequestData => {
    let queryParams: Record<string, string | number> = {
      size: DEFAULT_PAGE_SIZE,
      page: currentPage - 1,
    };

    if (sortBy !== "") {
      queryParams.sort = sortBy;
    }

    if (filter !== "") {
      currentRole === Roles.SERVICEMAN
        ? (queryParams.client = filter)
        : (queryParams.licenseId = filter);
    }

    if (orderStatus !== "") {
      queryParams.status = orderStatus;
    }

    if (currentRole === Roles.CLIENT) {
      queryParams.client = currentUser;
    }

    return {
      method: RequestMethod.GET,
      endpoint: assignedToServiceman ? ApiEndpoints.GET_ALL_ORDERS_SERVICEMAN : ApiEndpoints.GET_ALL_ORDERS,
      queryParams: queryParams,
    };
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const success = (response: any) => {
    setOrders(response.content);
    setTotalPages(response.totalPages);
    setCurrentPage(response.number + 1);
  };

  const handleSortBy = (
    event: React.MouseEvent<HTMLTableCellElement>,
    value: any,
  ) => {
    setSortBy(sortBy === "" ? value : "");
  };

  const handleOrderStatus = (
    event: React.ChangeEvent<HTMLInputElement>,
    status: OrderStatus,
  ) => {
    setOrderStatus(event.target.checked ? (status as string) : "");
  };

  const handleAssignedToServiceman = (
    event: React.ChangeEvent<HTMLInputElement>,
    value: boolean,
  ) => {
    setAssignedToServiceman(value);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<ListData<DeviceData>>(getOrdersData())
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [orderStatus, sortBy, currentPage, totalPages, filter, assignedToServiceman]);

  return (
    <div className="list-container">
      <div className="list-header-bar">
        <ContainerRow
          type={InputType.BASIC}
          placeholder={t("tables.search")}
          onChangeValue={(event) => {
            setFilter(event.target.value);
          }}
          value={filter}
        />
        <p>
          {[
            OrderStatus.OPEN,
            OrderStatus.IN_PROGRESS,
            OrderStatus.FOR_SETTLEMENT,
            OrderStatus.CLOSED,
          ].map((status) => (
            <FormControlLabel
              key={status}
              control={
                <Checkbox
                  key={status}
                  checked={orderStatus === (status as string)}
                  onChange={(e) => handleOrderStatus(e, status)}
                />
              }
              label={t(`orders.${status.toLowerCase()}`)}
            />
          ))}
          {currentRole === Roles.SERVICEMAN && <FormControlLabel
            key={assignedToServiceman.toString()}
            control={
              <Checkbox
                key={assignedToServiceman.toString()}
                checked={assignedToServiceman}
                onChange={(e) =>
                  handleAssignedToServiceman(e, !assignedToServiceman)
                }
              />
            }
            label={t(`orders.assignedToServiceman`)}
          />}
        </p>
      </div>
      <Table className="list-content">
        <TableHead>
          <TableRow>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "serviceman")}
            >
              {t("orders.serviceman")}
            </TableCell>
            {currentRole !== Roles.CLIENT && (
              <TableCell
                className="list-header"
                onClick={(event) => handleSortBy(event, "client")}
              >
                {t("orders.client")}
              </TableCell>
            )}
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "orderType")}
            >
              {t("orders.orderType")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "orderStatus")}
            >
              {t("orders.orderStatus")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "delayed")}
            >
              {t("orders.delayed")}
            </TableCell>
            <TableCell className="list-header">
              {t("orders.dateOfOrderExecution")}
            </TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {orders?.map((order) => (
            <TableRow
              key={order.id}
              className="list-row"
              onClick={() => navigate(`/orders/${order.id}`)}
            >
              <TableCell>{order.licenseId}</TableCell>
              {currentRole !== Roles.CLIENT && (
                <TableCell>{order.client}</TableCell>
              )}
              <TableCell>
                {t(`orders.ordersQueue.${order.orderType.toLowerCase()}`)}
              </TableCell>
              <TableCell>{t(`orders.${order.status.toLowerCase()}`)}</TableCell>
              <TableCell>
                {order.delayed && t(`orders.${order.delayed}`)}
              </TableCell>
              <TableCell>{order.dateOfOrderExecution.split("T")[0]}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <div className="list-pagination">
        <Pagination
          page={currentPage}
          count={totalPages}
          onChange={(event, page) => setCurrentPage(page)}
          color="primary"
        />
        <LoopIcon
          className="list-button"
          onClick={(event) =>
            requestService
              .sendRequestAndGetResponse<
                ListData<OrderListDetails>
              >(getOrdersData())
              .then(success)
          }
        />
      </div>
      <NotificationHandler
        isOpenConfirm={false}
        onChangeConfirm={() => {}}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={getOrdersData()}
        afterSuccessHandling={success}
      />
    </div>
  );
};
export default OrdersList;
