import RegistrationFirstPage from "./RegistrationFirstPage";
import React, {useEffect, useState} from "react";
import {Box, FormControl} from "@mui/material";
import ProgressBar from "../progressBar/ProgressBar";
import {useTranslation} from "react-i18next";
import RegistrationSecondPage from "./RegistrationSecondPage";
import RegistrationThirdPage from "./RegistrationThirdPage";
import BasicButton from "../buttons/BasicButton";
import BackArrow from "../buttons/BackArrow";
import {useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import {RequestService} from "../../api/RequestService";
import {RequestData, RequestMethod} from "../../api/RequestData";
import {ApiEndpoints} from "../../api/ApiEndpoints";
import DialogWindow from "../feedback/DialogWindow";
import BasicAlert, {AlertType} from "../feedback/BasicAlert";
import {ErrorResponseData} from "../../api/ErrorResponseData";
import {ALERT_AUTOHIDE, API_URL} from "../../utils/consts";
import {useNavigate} from "react-router-dom";

const Registration = () => {
    const {t} = useTranslation();
    const navigate = useNavigate();
    const registrationData = useSelector((state: RootState) => state.registration);
    const amountOfPages = 3;
    const requestService = new RequestService();
    const [currentPage, setCurrentPage] = useState(1);
    const [progress, setProgress] = useState(0);
    const [isOpen, setIsOpen] = useState(false);
    const [alertOpen, setAlertOpen] = useState(false);
    const [responseType, setResponseType] = useState<AlertType>(AlertType.SUCCESS);
    const [errorResponseData, setErrorResponseData] = useState<ErrorResponseData>();

    useEffect(() => {
        setProgress((100 / amountOfPages) * currentPage);
    }, [currentPage, progress]);

    const handleGoToNextPage = () => {
        currentPage + 1 > 3 ? setCurrentPage(3) : setCurrentPage(currentPage + 1);
    }

    const handleGoToPreviousPage = () => {
        currentPage - 1 < 1 ? setCurrentPage(1) : setCurrentPage(currentPage - 1);
    }

    const handleSubmit = async () => {
        let requestData: RequestData = {
            method: RequestMethod.POST,
            endpoint: ApiEndpoints.CLIENT_REGISTRATION_ENDPOINT,
            data: registrationData
        }
        setIsOpen(false);
        requestService.sendRequestAndGetResponse(requestData)
            .catch(error => {
                console.log("API_URL: ", API_URL);
                console.log("ERROR FROM API: ", error);
                console.log("ALERT AUTOHIDE: ", ALERT_AUTOHIDE);
                setResponseType(AlertType.ERROR);
                setErrorResponseData(error);
                setAlertOpen(true);
            });
    }

    return (
        <div className="registerContainer">
            {/*<DefaultMenu/>*/}
            <FormControl variant="standard" className="data-container-main">
                <BackArrow onClick={() => navigate('/')}/>
                <h2>{t('registration.register')}</h2>
                <ProgressBar progress={progress}/>
                {currentPage === 1 && <RegistrationFirstPage/>}
                {currentPage === 2 && <RegistrationSecondPage/>}
                {currentPage === 3 && <RegistrationThirdPage/>}
                <Box className="data-container-buttons">
                    {currentPage !== 1 && <BackArrow onClick={handleGoToPreviousPage}/>}
                    <BasicButton
                        content={currentPage === 3 ? t('buttons.submit') : t('buttons.next')}
                        onClick={currentPage < 3 ? handleGoToNextPage : async () => setIsOpen(true)}
                    />
                </Box>
            </FormControl>
            <DialogWindow
                isOpen={isOpen}
                onConfirm={handleSubmit}
                onClose={() => setIsOpen(false)}
            />
            <BasicAlert
                type={responseType}
                open={alertOpen}
                onClose={() => setAlertOpen(false)}
                content={t(errorResponseData?.message)}/>
        </div>
    );
}
export default Registration;