import {useTranslation} from "react-i18next";
import BasicButton from "../buttons/BasicButton";
import {useNavigate, useParams} from "react-router-dom";
import {useEffect, useState} from "react";
import {RequestData, RequestMethod} from "../../api/RequestData";
import {ApiEndpoints} from "../../api/ApiEndpoints";
import {useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import {Roles} from "../../security/Roles";
import {RequestService} from "../../api/RequestService";

const RegistrationPassed = () => {
    const {t} = useTranslation();
    const navigate = useNavigate();
    const {confirmationToken} = useParams();
    const requestService = RequestService.getInstance();
    const currentRole = useSelector((state: RootState) => state.currentUser).currentRole as string;
    const [responseMessage, setResponseMessage] = useState<string>(confirmationToken ? 'registration.confirmation.success' : 'registration.confirmation.passed');
    
    const fetchData = () => {
        let requestData: RequestData = {
            method: RequestMethod.POST,
            endpoint: `${ApiEndpoints.ACCOUNT_ACTIVATION_ENDPOINT}`.replace(":confirmationToken", confirmationToken as string),
            data: {
                confirmationToken: confirmationToken
            },
        }
        requestService.sendRequestAndGetResponse(requestData)
            .catch(error => setResponseMessage(error.message));
    }

    useEffect(() => {
        if (currentRole === Roles.GUEST && confirmationToken) {
            fetchData();
        }
    }, [confirmationToken]);

    return (
        <div className="register-after">
            <div className="register-passed-left">
                <h1>{t(responseMessage)}</h1>
            </div>
            <div className="register-passed-right">
                <BasicButton content={t('buttons.mainPage')} onClick={() => navigate('/')}/>
            </div>
        </div>);
}
export default RegistrationPassed;