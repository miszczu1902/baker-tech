import BasicButton from "../buttons/BasicButton";
import {useTranslation} from "react-i18next";
import {useNavigate} from "react-router-dom";

const Forbidden = () => {
    const {t} = useTranslation();
    const navigate = useNavigate();

    return (
        <div className="register-after">
            <div className="register-passed-left">
                <h1>{t('error.forbidden')}</h1>
            </div>
            <div className="register-passed-right">
                <BasicButton content={t('buttons.mainPage')} onClick={() => navigate('/')}/>
            </div>
        </div>);
}
export default Forbidden;