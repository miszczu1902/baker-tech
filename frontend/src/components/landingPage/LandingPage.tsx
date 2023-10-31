import {Box} from "@mui/material";
import BasicButton from "../buttons/BasicButton";
import {useTranslation} from "react-i18next";
import DefaultMenu from "../naviagtion/DefaultMenu";

const LandingPage = () => {
    const {t} = useTranslation();
    return (
        <div className="default-container">
            <DefaultMenu/>
            <Box className="landing-background">
                <Box className="landing-container">
                    <h1 className="landing-text">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac lectus euismod ex dignissim
                        gravida. Morbi pharetra, felis eu tristique sollicitudin, ante nulla fermentum massa, ut suscipit
                        quam lacus a erat. Proin non scelerisque nisl. Mauris sed sem a est semper pretium quis id neque.
                        Praesent eget sem commodo, laoreet orci id, malesuada dolor. In hac habitasse platea dictumst. Morbi
                        interdum est at sodales placerat. Donec commodo cursus nulla, eget aliquet risus dignissim non.
                        Aenean mattis suscipit interdum.
                    </h1>
                    <BasicButton content={t("landingPage.register")} path="/register"/>
                    <BasicButton content={t("landingPage.login")} path="/login"/>
                </Box>
            </Box>
        </div>
    );
};
export default LandingPage;
