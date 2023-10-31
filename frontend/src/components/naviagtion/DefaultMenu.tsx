import {Box, Container} from "@mui/material";
import Logo from "../icons/Logo";
import LanguageChoice from "./LanguageChoice";
import {useNavigate} from "react-router-dom";

const DefaultMenu = () => {
    const navigate = useNavigate();
    return (
        <Box className="default-navbar">
            <Container className="default-navbar-logo">
                <Logo onClick={() => navigate('/')}/>
            </Container>
            <Container className="default-navbar-section">
                <LanguageChoice/>
            </Container>
        </Box>
    );
}
export default DefaultMenu;