import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { RequestService } from "../../../api/RequestService";
import { OrderDetails } from "../../../types/service/orders/OrderDetails";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { EditOrderData } from "../../../types/service/orders/EditOrderData";
import {
  setOpenAlert,
  setOpenConfirm
} from "../../../redux/actions/notificationActions";
import OrderDetailsDisplay from "./edit/OrderDetailsDisplay";
import OrderEditForm from "./edit/OrderEditForm";
import OrderActions from "./edit/OrderActions";

const OrderData = () => {
  const { id } = useParams();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const [orderDetails, setOrderDetails] = useState<OrderDetails>();
  const orderToEditionData = useSelector(
    (state: RootState) => state.editOrder
  ) as EditOrderData;
  const orderInEdition = useSelector((state: RootState) => state.orderState)
    .orderInEdition as boolean;

  const getOrderDetailsRequestData = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_ORDER.replace(":id", id as string)
    };
  };

  const successOrderDetails = (arg: any) => {
    setOrderDetails(arg as OrderDetails);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<OrderDetails>(getOrderDetailsRequestData())
      .then(successOrderDetails)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [
    orderToEditionData.forSettlement,
    orderToEditionData.forClose,
    orderInEdition,
    id
  ]);

  return (
    <div className="data-display-element-container">
      <OrderDetailsDisplay orderDetails={orderDetails} />
      {orderInEdition && <OrderEditForm orderDetails={orderDetails} />}
      <OrderActions orderDetails={orderDetails} />
    </div>
  );
};
export default OrderData;
