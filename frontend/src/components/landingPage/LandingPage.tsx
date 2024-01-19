import { Box } from "@mui/material";
import BasicButton from "../buttons/BasicButton";
import { useTranslation } from "react-i18next";
import { useKeycloak } from "@react-keycloak/web";
import { login } from "../../keycloak/keycloakService";

const LandingPage = () => {
  const { t } = useTranslation();
  const { keycloak } = useKeycloak();

  return (
    <div className="default-container">
      <Box className="landing-background">
        <Box className="landing-container">
          <h1 className="landing-text">
            {t('landingPage.text')}
          </h1>
          <BasicButton content={t("landingPage.register")} path="/register" />
          <BasicButton
            content={t("landingPage.login")}
            onClick={() => login(keycloak)}
          />
        </Box>
      </Box>
    </div>
  );
};
export default LandingPage;
