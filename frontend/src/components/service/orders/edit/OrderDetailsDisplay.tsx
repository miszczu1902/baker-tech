import React, { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { OrderDetails } from "../../../../types/service/orders/OrderDetails";
import { OrderType } from "../../../../types/service/orders/OrderType";
import BasicButton from "../../../buttons/BasicButton";
import { useNavigate, useParams } from "react-router-dom";
import { RequestService } from "../../../../api/RequestService";
import { RequestData, RequestMethod } from "../../../../api/RequestData";
import { ApiEndpoints } from "../../../../api/ApiEndpoints";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../../redux/actions/notificationActions";
import { NextConservation } from "../../../../types/service/orders/NextConservation";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../../redux/store";
import ListSelectContainer from "../../../containers/ListSelectContainer";
import { OrderStatus } from "../../../../types/service/orders/OrderStatus";

export interface OrderDetailsDisplayProps {
  orderDetails?: OrderDetails;
}

const OrderDetailsDisplay: React.FC<OrderDetailsDisplayProps> = ({
  orderDetails,
}) => {
  const { id } = useParams();
  const { t } = useTranslation();
  const navigate = useNavigate();
  const orderInEdition = useSelector((state: RootState) => state.orderState)
    .orderInEdition as boolean;
  const dispatch = useDispatch();
  const requestService = RequestService.getInstance();
  const [isOpenConfig, setIsOpenConfig] = useState<boolean>(false);
  const [nextConservation, setNextConservation] = useState<NextConservation>();

  const getNextConservationRequestData = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_NEXT_CONSERVATION.replace(":id", id as string),
    };
  };

  useEffect(() => {
    if (
      orderDetails?.orderType === OrderType.CONSERVATION &&
      orderDetails?.status === OrderStatus.CLOSED
    ) {
      requestService
        .sendRequestAndGetResponse<NextConservation>(
          getNextConservationRequestData(),
        )
        .then((response) => setNextConservation(response));
    }
  }, [orderInEdition, id]);

  return (
    <div className="data-left-part">
      <p>
        <b>{t("orders.id")}: </b>
        {orderDetails?.id}
      </p>
      <p>
        <b>{t("orders.client")}: </b>
        {orderDetails?.client}
      </p>
      <p>
        <b>{t("orders.serviceman")}: </b>
        {orderDetails?.licenseId}
      </p>
      <p>
        <b>{t("orders.orderStatus")}: </b>
        {t(`orders.${orderDetails?.status.toLowerCase()}`)}
      </p>
      <p>
        <b>{t("orders.orderType")}: </b>
        {t(`orders.ordersQueue.${orderDetails?.orderType?.toLowerCase()}`)}
      </p>
      <p>
        <b>
          {orderDetails?.orderData?.totalCost && `${t("orders.totalCost")}: `}
        </b>
        {orderDetails?.orderData?.totalCost &&
          orderDetails?.orderData?.totalCost}
      </p>
      <p>
        <b>{t("orders.orderData")} </b>
        <p>
          <b>
            {orderDetails?.orderType === OrderType.CONSERVATION &&
              orderDetails?.conservation &&
              orderDetails?.conservation?.lastConservation !== undefined &&
              `${t("orders.lastConservation")}: `}
            {orderDetails?.conservation &&
              orderDetails?.conservation?.lastConservation !== undefined && (
                <BasicButton
                  content={t("buttons.display")}
                  onClick={() =>
                    navigate(
                      `/orders/${orderDetails?.conservation?.lastConservation}`,
                    )
                  }
                />
              )}
          </b>
        </p>
        <p>
          <b>
            {nextConservation
              ? `${t("orders.nextConservation")}: `
              : orderDetails?.orderType === OrderType.CONSERVATION &&
                orderDetails.status === OrderStatus.CLOSED &&
                `${t("orders.dateOfNextDeviceConservation")}: `}
            {nextConservation ? (
              <BasicButton
                content={t("buttons.display")}
                onClick={() =>
                  navigate(`/orders/${nextConservation?.nextConservation}`)
                }
              />
            ) : (
              orderDetails?.orderType === OrderType.CONSERVATION &&
              orderDetails?.conservation?.dateOfNextDeviceConservation.split(
                "T",
              )[0]
            )}
          </b>
          <b>
            {orderDetails?.warrantyRepair &&
              `${t("orders.lastDateOfDeviceService")}: `}
          </b>
          {orderDetails?.warrantyRepair &&
            orderDetails?.warrantyRepair?.lastDateOfDeviceService.split("T")[0]}
        </p>
        <p>
          <b>
            {`${t("orders.devicesList")}: `}
            <BasicButton
              content={t("buttons.display")}
              onClick={() => setIsOpenConfig(true)}
            />
            <ListSelectContainer
              toCreation={false}
              deviceForConservation={
                orderDetails?.orderType === OrderType.CONSERVATION
              }
              deviceForSelect={false}
              isOpen={isOpenConfig}
              onConfirm={() => {
                setIsOpenConfig(false);
              }}
              onClose={() => setIsOpenConfig(false)}
            />
          </b>
        </p>
      </p>
      <p>
        <b>{t("orders.description")}: </b>
        {orderDetails?.orderData?.description}
      </p>
    </div>
  );
};

export default OrderDetailsDisplay;
