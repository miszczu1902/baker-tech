import NotificationHandler from "../../response/NotificationHandler";
import React, { useState } from "react";
import { RequestService } from "../../../api/RequestService";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { useNavigate } from "react-router-dom";
import BasicButton from "../../buttons/BasicButton";
import { useTranslation } from "react-i18next";
import { useDispatch } from "react-redux";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

interface EndDeviceWarrantyProps {
  id: number | string;
}

const EndDeviceWarranty: React.FC<EndDeviceWarrantyProps> = ({ id }) => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const getDeviceETag = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_DEVICE.replace(":id", id as string),
    };
  };

  const endWarrantyRequestData = (): RequestData => {
    return {
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.END_DEVICE_WARRANTY.replace(":id", id as string),
    };
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpen(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const redirectToList = () => {
    navigate("/devices");
  };

  return (
    <div>
      <BasicButton
        content={t("devices.endWarranty")}
        onClick={() => {
          requestService
            .sendRequestAndGetResponse<void>(getDeviceETag())
            .then()
            .catch(() => {
              dispatch(setOpenConfirm(false));
              dispatch(setOpenAlert(true));
            });
          handleParentIsOpenState(true);
          handleParentIsOpenAlertState(false);
        }}
      />
      <NotificationHandler
        isOpenConfirm={isOpen}
        onChangeConfirm={handleParentIsOpenState}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={endWarrantyRequestData()}
        message={"alerts.modification"}
        afterSuccessHandling={redirectToList}
      />
    </div>
  );
};
export default EndDeviceWarranty;
