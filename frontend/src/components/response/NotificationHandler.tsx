import DialogWindow from "../feedback/DialogWindow";
import BasicAlert, { AlertType } from "../feedback/BasicAlert";
import React, { useEffect, useState } from "react";
import { RequestData } from "../../api/RequestData";
import { RequestService } from "../../api/RequestService";
import { useTranslation } from "react-i18next";
import { ErrorResponseData } from "../../api/ErrorResponseData";

export interface NotificationHandlerProps {
  isOpenConfirm: boolean;
  onChangeConfirm: (arg: boolean) => void;
  isOpenAlert: boolean;
  onChangeAlert: (arg: boolean) => void;
  message?: string;
  requestData?: RequestData;
  afterSuccessHandling?: (arg: any) => void;
}

const NotificationHandler: React.FC<NotificationHandlerProps> = ({
  isOpenConfirm,
  onChangeConfirm,
  isOpenAlert,
  onChangeAlert,
  requestData,
  afterSuccessHandling,
}) => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [alertOpen, setAlertOpen] = useState<boolean>(false);
  const [responseType, setResponseType] = useState<AlertType>();
  const [errorResponseData, setErrorResponseData] =
    useState<ErrorResponseData>();
  const [msg, setMsg] = useState<string>();

  const handleSubmit = () => {
    requestService
      .sendRequestAndGetResponse(requestData as RequestData)
      .then(success => {
        setResponseType(AlertType.SUCCESS);
        setMsg("alerts.success");
        if (afterSuccessHandling) {
          afterSuccessHandling(success);
        }
      })
      .catch((error) => {
        setResponseType(AlertType.ERROR);
        setErrorResponseData(error);
        setMsg(error?.message as string);
      })
      .finally(() => {
        handleLocalIsOpenState();
        handleLocalIsOpenAlertState();
      });
  };

  const handleLocalIsOpenState = () => {
    const newState: boolean = !isOpenConfirm;
    setIsOpen(newState);
    onChangeConfirm(newState);
  };

  const handleLocalIsOpenAlertState = () => {
    const newState: boolean = !isOpenAlert;
    setAlertOpen(newState);
    onChangeAlert(newState);
  };

  useEffect(() => {
    setIsOpen(isOpenConfirm ? isOpenConfirm : false);
    setAlertOpen(isOpenAlert);
  }, [isOpenConfirm, isOpenAlert, msg]);

  return (
    <div>
      <DialogWindow
        isOpen={isOpen}
        onConfirm={handleSubmit}
        onClose={handleLocalIsOpenState}
      />
      <BasicAlert
        type={responseType}
        open={alertOpen}
        onClose={handleLocalIsOpenAlertState}
        content={msg}
      />
    </div>
  );
};
export default NotificationHandler;
