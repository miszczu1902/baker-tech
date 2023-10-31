import {Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle} from "@mui/material";
import {useTranslation} from "react-i18next";
import BasicButton from "../buttons/BasicButton";

export interface FeedbackProps {
    isOpen: boolean;
    onConfirm: () => void;
    onClose?: () => void;
}

const DialogWindow: React.FC<FeedbackProps> = ({isOpen, onConfirm, onClose}) => {
    const {t} = useTranslation();
    return (
        <Dialog
            open={isOpen}
            onClose={onClose}
            aria-describedby="alert-dialog-slide-description"
        >
            <DialogTitle>{t("alerts.title")}</DialogTitle>
            <DialogContent>
                <DialogContentText id="alert-dialog-slide-description">
                    {t("alerts.confirmMessage")}
                </DialogContentText>
            </DialogContent>
            <DialogActions>
                <BasicButton content={t("alerts.disagree")} onClick={onClose}/>
                <BasicButton content={t("alerts.agree")} onClick={onConfirm}/>
            </DialogActions>
        </Dialog>
    )
}
export default DialogWindow;