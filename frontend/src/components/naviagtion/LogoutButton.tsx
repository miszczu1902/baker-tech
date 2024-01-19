import { useKeycloak } from "@react-keycloak/web";
import BasicButton from "../buttons/BasicButton";
import { useDispatch } from "react-redux";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { logout } from "../../keycloak/keycloakService";

const LogoutButton = () => {
  const { t } = useTranslation();
  const { keycloak } = useKeycloak();
  const navigate = useNavigate();
  const dispatch = useDispatch();

  return (
    <div>
      <BasicButton
        content={t("landingPage.logout")}
        onClick={() => logout(keycloak)}
      />
    </div>
  );
};
export default LogoutButton;
