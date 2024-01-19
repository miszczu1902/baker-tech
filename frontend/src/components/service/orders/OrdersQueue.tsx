import { RequestService } from "../../../api/RequestService";
import React, { useEffect, useState } from "react";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ORDERS_QUEUE_PAGE_SIZE } from "../../../utils/consts";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { ListData } from "../../../types/ListData";
import { OrdersQueueListData } from "../../../types/service/orders/OrdersQueueListData";
import NotificationHandler from "../../response/NotificationHandler";
import OrderTile from "./OrderTile";
import { Pagination } from "@mui/material";
import { setOpenAlert, setOpenConfirm } from "../../../redux/actions/notificationActions";
import { useDispatch } from "react-redux";

const OrdersQueue = () => {
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const [ordersQueue, setOrdersQueue] = useState<OrdersQueueListData[]>();
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>();
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const getOrdersQueueData = (): RequestData => {
    let queryParams: Record<string, string | number> = {
      size: ORDERS_QUEUE_PAGE_SIZE,
      page: currentPage - 1,
    };

    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.ORDERS_QUEUE,
      queryParams: queryParams,
    };
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const success = (response: any) => {
    if (!ordersQueue) {
      setOrdersQueue(response.content);
      setTotalPages(response.totalPages);
      setCurrentPage(response.number + 1);
    }
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<
        ListData<OrdersQueueListData>
      >(getOrdersQueueData())
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [currentPage, totalPages]);

  return (
    <div className="orders-queue-container">
      <div className="orders-queue-header">
        <Pagination
          page={currentPage}
          count={totalPages}
          onChange={(event, page) => setCurrentPage(page)}
          color="primary"
        />
      </div>
      {ordersQueue?.map((order) => (
        <OrderTile orderData={order} key={order.id} />
      ))}
      <NotificationHandler
        isOpenConfirm={false}
        onChangeConfirm={() => {}}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={getOrdersQueueData()}
        afterSuccessHandling={(arg: any) => {
          handleParentIsOpenAlertState(true);
          success(arg);
        }}
        message={undefined}
      />
    </div>
  );
};
export default OrdersQueue;
