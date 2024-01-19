import React, { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { Box, Checkbox, FormControlLabel } from "@mui/material";
import { validatePositiveValue } from "../../../../utils/regexpValidator";
import { OrderStatus } from "../../../../types/service/orders/OrderStatus";
import ContainerRow, { InputType } from "../../../containers/ContainerRow";
import { OrderType } from "../../../../types/service/orders/OrderType";
import { Roles } from "../../../../security/Roles";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../../redux/store";
import { EditOrderData } from "../../../../types/service/orders/EditOrderData";
import Typography from "@mui/material/Typography";
import BasicButton from "../../../buttons/BasicButton";
import ListSelectContainer from "../../../containers/ListSelectContainer";
import {
  closeOrder,
  sendOrderToSettlement,
} from "../../../../redux/actions/editOrderActions";
import { OrderDetailsDisplayProps } from "./OrderDetailsDisplay";

const OrderEditForm: React.FC<OrderDetailsDisplayProps> = ({
  orderDetails
}) => {
  const { t } = useTranslation();
  const dispatch = useDispatch();
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as Roles;
  const orderToEditionData = useSelector(
    (state: RootState) => state.editOrder,
  ) as EditOrderData;
  const orderInEdition = useSelector((state: RootState) => state.orderState).orderInEdition as boolean;
  const [isOpenConfig, setIsOpenConfig] = useState<boolean>(false);
  const [reportAuto, setReportAuto] = useState<boolean>(true);
  const [validPositiveValue, setValidPositiveValue] = useState<boolean>(false);

  const handleValueChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    let value = Number(event.target.value);
    setValidPositiveValue(validatePositiveValue(value));

    if (orderInEdition) {
      if (orderDetails?.status === OrderStatus.IN_PROGRESS) {
        dispatch(
          sendOrderToSettlement({
            ...orderToEditionData.forSettlement,
            duration: value,
          }),
        );
      } else if (orderDetails?.status === OrderStatus.FOR_SETTLEMENT) {
        dispatch(
          closeOrder({
            ...orderToEditionData.forClose,
            totalCost: value,
          }),
        );
      }
    }
  };

  const handleReportAuto = (
    event: React.ChangeEvent<HTMLInputElement>,
    reportAutomatically: boolean,
  ) => {
    setReportAuto(event.target.checked ? reportAutomatically : false);
    dispatch(
      sendOrderToSettlement({
        ...orderToEditionData.forSettlement,
        reportNextAutomatically: reportAuto,
      }),
    );
  };

  useEffect(() => {
    if (orderDetails?.orderData.totalCost) {
      dispatch(
        closeOrder({
          ...orderToEditionData.forClose,
          totalCost: orderDetails?.orderData.totalCost,
        }),
      );
    }
  }, [orderInEdition]);

  return (
    <div className="data-right-part">
      {orderInEdition &&
        currentRole === Roles.SERVICEMAN &&
        orderDetails?.status === OrderStatus.IN_PROGRESS && (
          <Box flexGrow={1} className="center">
            <ContainerRow
              className="data-container-row small"
              placeholder={t("orders.duration") + "*"}
              type={InputType.NUMERICAL}
              onChangeValue={handleValueChange}
              value={orderToEditionData?.forSettlement?.duration}
              valid={validPositiveValue}
              validationText={t("validation.placeholder.positive")}
            />
            {orderDetails.orderType === OrderType.CONSERVATION && (
              <Box>
                <Typography>{t("orders.continue")}</Typography>
                {orderDetails?.orderType === OrderType.CONSERVATION &&
                  [true, false].map((report) => (
                    <FormControlLabel
                      key={report.toString()}
                      control={
                        <Checkbox
                          key={report.toString()}
                          checked={reportAuto === report}
                          onChange={(e) => handleReportAuto(e, report)}
                        />
                      }
                      label={t(`orders.${report}`)}
                    />
                  ))}
              </Box>
            )}
            {orderDetails?.orderType !== OrderType.NON_WARRANTY_REPAIR && (
              <Box flexGrow={1} className="center">
                <Typography>{t("orders.devices")}</Typography>
                <BasicButton
                  content={t("buttons.select")}
                  onClick={() => setIsOpenConfig(true)}
                />
                <ListSelectContainer
                  toCreation={false}
                  isOpen={isOpenConfig}
                  onConfirm={() => {
                    setIsOpenConfig(false);
                  }}
                  onClose={() => setIsOpenConfig(false)}
                />
              </Box>
            )}
            <Box>{t("registration.mandatory")}</Box>
          </Box>
        )}
      {orderInEdition &&
        currentRole === Roles.ADMINISTRATOR &&
        orderDetails?.status === OrderStatus.FOR_SETTLEMENT && (
          <div className="data-right-part">
            <ContainerRow
              className="data-container-row micro"
              placeholder={t("orders.totalCost") + "*"}
              type={InputType.NUMERICAL}
              onChangeValue={handleValueChange}
              value={orderToEditionData.forClose?.totalCost}
              valid={validPositiveValue}
              validationText={t("validation.placeholder.positive")}
            />
            <Box>{t("registration.mandatory")}</Box>
          </div>
        )}
    </div>
  );
};

export default OrderEditForm;
