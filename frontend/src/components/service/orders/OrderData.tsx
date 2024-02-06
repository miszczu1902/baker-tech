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
import { OrderStatus } from "../../../types/service/orders/OrderStatus";
import BasicButton from "../../buttons/BasicButton";
import NotificationHandler from "../../response/NotificationHandler";
import { Roles } from "../../../security/Roles";
import { useTranslation } from "react-i18next";

const OrderData = () => {
  const { id } = useParams();
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const [orderDetails, setOrderDetails] = useState<OrderDetails>();
  const orderToEditionData = useSelector(
    (state: RootState) => state.editOrder
  ) as EditOrderData;
  const orderInEdition = useSelector((state: RootState) => state.orderState)
    .orderInEdition as boolean;
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as Roles;
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const getOrderDetailsRequestData = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_ORDER.replace(":id", id as string)
    };
  };

  const successOrderDetails = (arg: any) => {
    setOrderDetails(arg as OrderDetails);
  };

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.ASSIGN_SERVICEMAN_TO_ORDER.replace(
        ":id",
        orderDetails?.id.toString() as string
      )
    };
  };

  const getOrderETag = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_ORDER.replace(
        ":id",
        orderDetails?.id.toString() as string
      )
    };
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpen(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const updateData = () => {
    requestService
      .sendRequestAndGetResponse<OrderDetails>(getOrderDetailsRequestData())
      .then(successOrderDetails)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  };

  useEffect(() => {
    updateData();
  }, [
    orderToEditionData.forSettlement,
    orderToEditionData.forClose,
    orderInEdition,
    orderDetails,
    id
  ]);

  return (
    <div className="data-display-element-container">
      <OrderDetailsDisplay orderDetails={orderDetails} />
      {!orderInEdition &&
        orderDetails?.status === OrderStatus.OPEN &&
        currentRole === Roles.SERVICEMAN && (
          <p>
            <BasicButton
              content={t("orders.assign")}
              onClick={() => {
                requestService
                  .sendRequestAndGetResponse<void>(getOrderETag())
                  .then();
                handleParentIsOpenState(true);
                handleParentIsOpenAlertState(false);
              }}
            />
            <NotificationHandler
              isOpenConfirm={isOpen}
              onChangeConfirm={handleParentIsOpenState}
              isOpenAlert={isOpenAlert}
              onChangeAlert={handleParentIsOpenAlertState}
              requestData={getRequestData()}
              afterSuccessHandling={() => {
                handleParentIsOpenAlertState(true);
                getRequestData();
                updateData();
              }}
            />
          </p>
        )}
      {orderInEdition && <OrderEditForm orderDetails={orderDetails} />}
      <OrderActions orderDetails={orderDetails} />
    </div>
  );
};
export default OrderData;
