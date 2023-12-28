import DialogWindow from "../feedback/DialogWindow";
import BasicAlert, {AlertType} from "../feedback/BasicAlert";
import React, {useEffect, useState} from "react";
import {RequestData} from "../../api/RequestData";
import {RequestService} from "../../api/RequestService";
import {ErrorResponseData} from "../../api/ErrorResponseData";

interface NotificationHandlerProps {
    isOpenConfirm: boolean
    onChangeConfirm: (arg: boolean) => void,
    isOpenAlert: boolean
    onChangeAlert: (arg: boolean) => void,
    message?: string;
    requestData?: RequestData;
    afterSuccessHandling?: (arg: any) => void;
}

const NotificationHandler: React.FC<NotificationHandlerProps> = ({
                                                                     isOpenConfirm,
                                                                     onChangeConfirm,
                                                                     isOpenAlert,
                                                                     onChangeAlert,
                                                                     message,
                                                                     requestData,
                                                                     afterSuccessHandling
                                                                 }) => {
    const requestService = RequestService.getInstance();
    const [isOpen, setIsOpen] = useState<boolean>(false);
    const [alertOpen, setAlertOpen] = useState<boolean>(false);
    const [responseType, setResponseType] = useState<AlertType>(AlertType.SUCCESS);
    const [errorResponseData, setErrorResponseData] = useState<ErrorResponseData>();

    const handleSubmit = () => {
        handleLocalIsOpenState();
        requestService.sendRequestAndGetResponse(requestData as RequestData)
            .then(afterSuccessHandling)
            .catch(error => {
                setResponseType(AlertType.ERROR);
                setErrorResponseData(error);
            })
            .finally(() => {
                if (responseType === AlertType.ERROR || (responseType === AlertType.SUCCESS && message)) {
                    handleLocalIsOpenAlertState();
                }
            });
    }

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
    }, [isOpenConfirm, isOpenAlert]);

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
                content={message && responseType === AlertType.SUCCESS ? message : errorResponseData?.message}/>
        </div>
    );
}
export default NotificationHandler;