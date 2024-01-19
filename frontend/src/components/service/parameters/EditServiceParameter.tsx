import React, { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import BasicButton from "../../buttons/BasicButton";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import EditParameterDialogWindow from "./EditParameterDialogWindow";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { setNewServiceParameterValue } from "../../../redux/actions/parameterActions";
import NotificationHandler from "../../response/NotificationHandler";

interface EditServiceParameterProps {
  id: number | string;
  value?: any;
}

const EditServiceParameter: React.FC<EditServiceParameterProps> = ({
  id,
  value,
}) => {
  const parameterValue = useSelector(
    (state: RootState) => state.serviceParams,
  ).value;
  const dispatch = useDispatch();
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const [isOpenEditData, setIsOpenEditData] = useState<boolean>(false);
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const getParameterETag = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_PARAM.replace(":id", id as string),
    };
  };

  const editServiceParamRequestData = (): RequestData => {
    return {
      method: RequestMethod.PATCH,
      endpoint: ApiEndpoints.GET_PARAM.replace(":id", id as string),
      data: { value: parameterValue },
    };
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpen(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  useEffect(() => {
    dispatch(
      setNewServiceParameterValue(value),
    );
  }, [parameterValue]);

  return (
    <div>
      <BasicButton
        content={t("admin.edit")}
        onClick={() => {
          requestService
            .sendRequestAndGetResponse<void>(getParameterETag())
            .then();
          setIsOpenEditData(true);
        }}
      />
      <EditParameterDialogWindow
        isOpen={isOpenEditData}
        onConfirm={() => {
          setIsOpenEditData(false);
          setIsOpen(true);
          setIsOpenAlert(false);
        }}
        onClose={() => {
          setIsOpenEditData(false);
          setIsOpen(false);
          setIsOpenAlert(false);
        }}
      />
      <NotificationHandler
        isOpenConfirm={isOpen}
        onChangeConfirm={handleParentIsOpenState}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={editServiceParamRequestData()}
        message={"alerts.modification"}
      />
    </div>
  );
};
export default EditServiceParameter;
