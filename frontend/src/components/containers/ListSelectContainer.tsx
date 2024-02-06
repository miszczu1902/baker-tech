import React from "react";
import { FeedbackProps } from "../feedback/DialogWindow";
import { useTranslation } from "react-i18next";
import { Dialog, DialogActions, DialogContent } from "@mui/material";
import BasicButton from "../buttons/BasicButton";
import DevicesList from "../service/devices/DevicesList";
import AccountsList from "../accounts/AccountsList";

interface ListSelectContainerProps extends FeedbackProps {
  toCreation: boolean;
  deviceForConservation: boolean;
  deviceForSelect: boolean;
}

const ListSelectContainer: React.FC<ListSelectContainerProps> = ({
  toCreation,
  isOpen,
  onClose,
  deviceForConservation,
  deviceForSelect,
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
          <DevicesList
            isSubSelectList={true}
            deviceForConservation={deviceForConservation}
            deviceForSelect={deviceForSelect}
          />
        )}
      </DialogContent>
      <DialogActions>
        <BasicButton content={t("alerts.disagree")} onClick={onClose} />
      </DialogActions>
    </Dialog>
  );
};
export default ListSelectContainer;
