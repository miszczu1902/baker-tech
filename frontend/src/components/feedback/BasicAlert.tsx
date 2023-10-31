import {Alert, Snackbar} from "@mui/material";
import {useTranslation} from "react-i18next";
import {ALERT_AUTOHIDE} from "../../utils/consts";

export enum AlertType {
    SUCCESS = 'success',
    ERROR = 'error'
}

export interface AlertProps {
    type: AlertType;
    content?: string;
    open: boolean;
    onClose: () => void;
}

const BasicAlert: React.FC<AlertProps> = ({type, content, open, onClose}) => {
    const {t} = useTranslation();
    return (
        <Snackbar autoHideDuration={ALERT_AUTOHIDE} open={open} onClose={onClose}>
            <Alert variant="filled" severity={type}>
                {content ? t(content) : t("error.internalServer")}
            </Alert>
        </Snackbar>
    )
}
export default BasicAlert;