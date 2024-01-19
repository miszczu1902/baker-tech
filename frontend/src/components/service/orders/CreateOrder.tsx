import { useTranslation } from "react-i18next";
import React, { useEffect, useState } from "react";
import { CreateOrderType } from "../../../types/service/orders/CreateOrderType";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { useNavigate } from "react-router-dom";
import { Box, Checkbox, Chip, FormControl, FormControlLabel } from "@mui/material";
import { OrderType } from "../../../types/service/orders/OrderType";
import { delay } from "lodash";
import { ALERT_AUTOHIDE } from "../../../utils/consts";
import BasicButton from "../../buttons/BasicButton";
import ContainerRow, { InputType } from "../../containers/ContainerRow";
import {
  validateDescription,
  validateDeviceDataField,
} from "../../../utils/regexpValidator";
import { useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { Roles } from "../../../security/Roles";
import { DatePicker, LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { Dayjs } from "dayjs";
import ListSelectContainer from "../../containers/ListSelectContainer";
import NotificationHandler from "../../response/NotificationHandler";

const CreateOrder = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as Roles;
  const currentUser = useSelector(
    (state: RootState) => state.currentUser.currentUser,
  );
  let potentialClient = useSelector(
    (state: RootState) => state.orderToCreate.username,
  );
  const [isOpenConfig, setIsOpenConfig] = useState<boolean>(false);
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);
  const [orderType, setOrderType] = useState<OrderType>(
    OrderType.NON_WARRANTY_REPAIR,
  );
  const [createOrder, setCreateOrder] = useState<CreateOrderType>({
    orderType: orderType,
  });
  const [validDescription, setValidDescription] = useState<boolean>(
    validateDescription(createOrder?.description as string),
  );

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.GET_ALL_ORDERS,
      data: createOrder,
    };
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpen(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const handleOrderTypeChange = (
    event: React.ChangeEvent<HTMLInputElement>,
    type: OrderType,
  ) => {
    setOrderType(type);
    setCreateOrder((oldOrder) => ({
      ...oldOrder,
      orderType: type,
    }));
  };

  const handleDescriptionChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    let description = event.target.value;
    setValidDescription(validateDeviceDataField(description));
    setCreateOrder((oldOrder) => ({
      ...oldOrder,
      description: description,
    }));
  };

  useEffect(() => {
    if (currentRole === Roles.CLIENT) {
      potentialClient = currentUser;
      setCreateOrder({ ...createOrder, client: potentialClient });
    }
  }, [validDescription, orderType, potentialClient]);

  return (
    <div>
      <FormControl variant="standard" className="data-container-main">
        <div className="data-container-head-row">
          <h2 className="data-container-head-row-h2 ">{t("orders.add")}</h2>
        </div>
        <div className="data-edit-row center">
          {[
            OrderType.NON_WARRANTY_REPAIR,
            OrderType.WARRANTY_REPAIR,
            OrderType.CONSERVATION,
          ].map((type) => (
            <FormControlLabel
              key={type}
              control={
                <Checkbox
                  key={type}
                  checked={orderType === (type as OrderType)}
                  onChange={(e) => handleOrderTypeChange(e, type)}
                />
              }
              label={t(`orders.ordersQueue.${type.toLowerCase()}`)}
            />
          ))}
        </div>
        <ContainerRow
          className="small"
          placeholder={`${t("orders.description")}*`}
          type={InputType.BASIC}
          onChangeValue={handleDescriptionChange}
          value={createOrder?.description}
          valid={validDescription}
          validationText={t("validation.placeholder.description")}
        />
        {currentRole === Roles.SERVICEMAN && (
          <div className="data-edit-row with-padding center">
            <b>{`${t("orders.client")}*`} </b>
            <Chip
              className="data-chip-neutral"
              key={potentialClient}
              label={t(potentialClient)}
              onClick={() => setIsOpenConfig(true)}
            />
            <ListSelectContainer
              toCreation={true}
              isOpen={isOpenConfig}
              onConfirm={() => setIsOpenConfig(false)}
              onClose={() => {
                setIsOpenConfig(false);
                setCreateOrder({ ...createOrder, client: potentialClient });
              }}
            />
          </div>
        )}
        <div className="data-edit-row with-padding center">
          <LocalizationProvider dateAdapter={AdapterDayjs}>
            {orderType === OrderType.CONSERVATION && (
              <DatePicker
                className="tiny"
                label={`${t("orders.dateOfNextDeviceConservation")}*`}
                format="MM-DD-YYYY"
                name="next"
                onChange={(value: Dayjs | null, context) =>
                  setCreateOrder({
                    ...createOrder,
                    nextOrderData: {
                      dateOfNextDeviceConservation: value?.toISOString(),
                    },
                  })
                }
              />
            )}
            {orderType === OrderType.WARRANTY_REPAIR && (
              <DatePicker
                className="tiny"
                label={`${t("orders.lastDateOfDeviceService")}*`}
                format="MM-DD-YYYY"
                name="last"
                onChange={(value: Dayjs | null, context) =>
                  setCreateOrder({
                    ...createOrder,
                    nextOrderData: {
                      lastDateOfDeviceService: value?.toISOString(),
                    },
                  })
                }
              />
            )}
          </LocalizationProvider>
        </div>
        <div>
          <BasicButton
            content={t("buttons.submit")}
            onClick={() => {
              handleParentIsOpenState(true);
              handleParentIsOpenAlertState(false);
            }}
          />
          <Box>{t("registration.mandatory")}</Box>
        </div>
        <NotificationHandler
          isOpenConfirm={isOpen}
          onChangeConfirm={handleParentIsOpenState}
          isOpenAlert={isOpenAlert}
          onChangeAlert={handleParentIsOpenAlertState}
          requestData={getRequestData()}
          afterSuccessHandling={() => {
            handleParentIsOpenAlertState(true);
            delay(() => navigate("/orders"), ALERT_AUTOHIDE / 3);
          }}
          message={"alerts.modification"}
        />
      </FormControl>
    </div>
  );
};
export default CreateOrder;