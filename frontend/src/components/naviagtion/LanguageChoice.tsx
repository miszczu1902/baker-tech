import {Box} from "@mui/material";
import {GB, PL} from "country-flag-icons/react/3x2";
import {useEffect, useState} from "react";
import i18n from "../../i18n";
import {Languages} from "../../types/Languages";

const LanguageChoice = () => {
    const [currentLanguage, setCurrentLanguage] = useState(localStorage.getItem("language"))

    useEffect(() => {
        if (currentLanguage) {
            i18n.changeLanguage(currentLanguage);
        }
    }, [currentLanguage]);

    const handleLanguageChange = (newLanguage: Languages) => {
        setCurrentLanguage(newLanguage);
        localStorage.setItem("language", newLanguage);
    };

    return (
        <Box className="data-container-languages">
            <PL title="PL"
                className="language-flag"
                onClick={() => handleLanguageChange(Languages.pl)}
            />
            <GB title="GB"
                className="language-flag"
                onClick={() => handleLanguageChange(Languages.en)}
            />
        </Box>
    );
}
export default LanguageChoice;