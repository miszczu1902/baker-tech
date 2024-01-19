import { OrdersQueueListData } from "../../../types/service/orders/OrdersQueueListData";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import BasicButton from "../../buttons/BasicButton";
import { useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { Roles } from "../../../security/Roles";
import { delay } from "lodash";
import { ALERT_AUTOHIDE } from "../../../utils/consts";
import NotificationHandler from "../../response/NotificationHandler";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { RequestService } from "../../../api/RequestService";

interface OrderTileProps {
  orderData: OrdersQueueListData;
  key?: any;
}

const OrderTile: React.FC<OrderTileProps> = ({ orderData, key }) => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const navigate = useNavigate();
  const date = new Date(orderData.dateOfOrderExecution);
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as Roles;
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.ASSIGN_SERVICEMAN_TO_ORDER.replace(
        ":id",
        orderData.id.toString(),
      ),
    };
  };

  const getOrderETag = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_ORDER.replace(":id", orderData.id.toString()),
    };
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpen(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  return (
    <div
      className={
        orderData.delayed ? "orders-queue-tile delayed" : "orders-queue-tile"
      }
    >
      <h3>{t(`orders.ordersQueue.${orderData.orderType.toLowerCase()}`)}</h3>
      <p>
        {t("orders.ordersQueue.date")}:{" "}
        <b>{date.toLocaleDateString().split("T")[0]}</b>
      </p>
      <p>
        {t("orders.ordersQueue.client")}: <b>{orderData.client}</b>
      </p>
      <p>
        {t("orders.ordersQueue.address")}: <b>{orderData.address}</b>
      </p>
      {currentRole === Roles.SERVICEMAN && (
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
              delay(() => navigate(`/orders/${orderData.id}`), ALERT_AUTOHIDE / 3);
            }}
            message={"alerts.modification"}
          />
        </p>
      )}
    </div>
  );
};
export default OrderTile;
