import {useKeycloak} from "@react-keycloak/web";
import BasicButton from "../buttons/BasicButton";
import {useDispatch} from "react-redux";
import {setAvailableRoles, setCurrentRole, setCurrentUser} from "../../redux/actions/authAction";
import {Roles} from "../../security/Roles";
import {useTranslation} from "react-i18next";
import {useNavigate} from "react-router-dom";
import {redirectAfter} from "../../keycloak/keycloakService";

const LogoutButton = () => {
    const {t} = useTranslation();
    const {keycloak} = useKeycloak();
    const navigate = useNavigate();
    const dispatch = useDispatch();

    const handleLogout = () => {
        navigate('/');
        keycloak.logout();
        dispatch(setCurrentRole(Roles.GUEST));
        dispatch(setAvailableRoles([Roles.GUEST]));
        dispatch(setCurrentUser(''));
        redirectAfter();
    };

    return (
        <div>
            <BasicButton content={t('landingPage.logout')} onClick={handleLogout}/>
        </div>
    );
}
export default LogoutButton;