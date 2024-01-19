import React from "react";
import { FeedbackProps } from "../feedback/DialogWindow";
import { useTranslation } from "react-i18next";
import { Dialog, DialogActions, DialogContent } from "@mui/material";
import BasicButton from "../buttons/BasicButton";
import DevicesList from "../service/devices/DevicesList";
import AccountsList from "../accounts/AccountsList";

interface ListSelectContainerProps extends FeedbackProps {
  toCreation: boolean;
}

const ListSelectContainer: React.FC<ListSelectContainerProps> = ({
  toCreation,
  isOpen,
  onClose,
}) => {
  const { t } = useTranslation();

  return (
    <Dialog
      className="wide-dialog"
      open={isOpen}
      onClose={onClose}
      aria-describedby="alert-dialog-slide-description"
    >
      <DialogContent>
        {toCreation ? (
          <AccountsList isSubSelectList={true} />
        ) : (
          <DevicesList isSubSelectList={true} />
        )}
      </DialogContent>
      <DialogActions>
        <BasicButton content={t("alerts.disagree")} onClick={onClose} />
      </DialogActions>
    </Dialog>
  );
};
export default ListSelectContainer;
