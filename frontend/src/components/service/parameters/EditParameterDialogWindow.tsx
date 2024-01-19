import {
  Box,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle
} from "@mui/material";
import { useTranslation } from "react-i18next";
import ContainerRow, { InputType } from "../../containers/ContainerRow";
import { FeedbackProps } from "../../feedback/DialogWindow";
import React, { useEffect, useState } from "react";
import BasicButton from "../../buttons/BasicButton";
import { validatePositiveValue } from "../../../utils/regexpValidator";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { setNewServiceParameterValue } from "../../../redux/actions/parameterActions";

const EditParameterDialogWindow: React.FC<FeedbackProps> = ({
  isOpen,
  onConfirm,
  onClose,
}) => {
  const parameterValue = useSelector(
    (state: RootState) => state.serviceParams,
  ).value;
  const dispatch = useDispatch();
  const { t } = useTranslation();
  const [isValid, setIsValid] = useState<boolean>(
    validatePositiveValue(parameterValue),
  );

  const handleValueChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    let paramValue = Number(event.target.value);
    dispatch(setNewServiceParameterValue(paramValue));
  };

  useEffect(() => {
    setIsValid(validatePositiveValue(parameterValue));
  }, [parameterValue, isValid]);

  return (
    <Dialog
      open={isOpen}
      onClose={onClose}
      aria-describedby="alert-dialog-slide-description"
    >
      <DialogTitle>{t("admin.editParamValue")}</DialogTitle>
      <DialogContent>
        <ContainerRow
          className="param-content-row"
          placeholder={`${t("admin.editParamValuePlaceholder")}*`}
          type={InputType.BASIC}
          onChangeValue={handleValueChange}
          value={parameterValue}
        />
      </DialogContent>
      <DialogActions>
        {isValid && (
          <div>
            <BasicButton content={t("admin.cancel")} onClick={onClose} />
            <BasicButton content={t("admin.edit")} onClick={onConfirm} />
          </div>
        )}
        <Box>{t("registration.mandatory")}</Box>
      </DialogActions>
    </Dialog>
  );
};
export default EditParameterDialogWindow;
