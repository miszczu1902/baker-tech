import Box from "@mui/material/Box";
import React, { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { OrderStatus } from "../../../../types/service/orders/OrderStatus";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../../redux/store";
import { EditOrderData } from "../../../../types/service/orders/EditOrderData";
import { OrderDetailsDisplayProps } from "./OrderDetailsDisplay";
import BasicButton from "../../../buttons/BasicButton";
import NotificationHandler from "../../../response/NotificationHandler";
import { RequestData, RequestMethod } from "../../../../api/RequestData";
import { ApiEndpoints } from "../../../../api/ApiEndpoints";
import { changeOrderState } from "../../../../redux/actions/orderStateActions";
import { useParams } from "react-router-dom";
import { Roles } from "../../../../security/Roles";

const OrderActions: React.FC<OrderDetailsDisplayProps> = ({ orderDetails }) => {
  const { id } = useParams();
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as Roles;
  const orderToEditionData = useSelector(
    (state: RootState) => state.editOrder,
  ) as EditOrderData;
  const orderInEdition = useSelector((state: RootState) => state.orderState)
    .orderInEdition as boolean;
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const editOrderData = (): RequestData => {
    return {
      method: RequestMethod.PATCH,
      endpoint: ApiEndpoints.GET_ORDER.replace(":id", id as string),
      data: orderToEditionData,
    };
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpen(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  useEffect(() => {}, [orderInEdition]);

  return (
    <Box className="center">
      {orderDetails?.status !== OrderStatus.OPEN &&
        orderDetails?.status !== OrderStatus.CLOSED &&
        ((orderDetails?.status === OrderStatus.IN_PROGRESS &&
          currentRole === Roles.SERVICEMAN) ||
          (orderDetails?.status === OrderStatus.FOR_SETTLEMENT &&
            currentRole === Roles.ADMINISTRATOR)) && (
          <BasicButton
            content={t(
              orderInEdition &&
                (orderToEditionData?.forSettlement?.duration ||
                  orderToEditionData?.forClose?.totalCost)
                ? "buttons.submit"
                : orderInEdition &&
                    (!orderToEditionData?.forSettlement?.duration ||
                      !orderToEditionData?.forClose?.totalCost)
                  ? "alerts.disagree"
                  : "buttons.edit",
            )}
            onClick={() => {
              if (
                orderInEdition &&
                (orderToEditionData?.forSettlement?.duration ||
                  orderToEditionData?.forClose?.totalCost)
              ) {
                dispatch(changeOrderState(false));
                handleParentIsOpenState(true);
                handleParentIsOpenAlertState(false);
              } else if (
                orderInEdition &&
                (!orderToEditionData?.forSettlement?.duration ||
                  !orderToEditionData?.forClose?.totalCost)
              ) {
                dispatch(changeOrderState(false));
              } else {
                dispatch(changeOrderState(true));
                handleParentIsOpenState(false);
                handleParentIsOpenAlertState(false);
              }
            }}
          />
        )}
      <NotificationHandler
        isOpenConfirm={isOpen}
        onChangeConfirm={handleParentIsOpenState}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={editOrderData()}
        afterSuccessHandling={() => handleParentIsOpenAlertState(true)}
        message={"alerts.modification"}
      />
    </Box>
  );
};

export default OrderActions;
