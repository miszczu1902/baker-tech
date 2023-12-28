import {Box} from "@mui/material";
import {GB, PL} from "country-flag-icons/react/3x2";
import {useEffect} from "react";
import i18n from "../../i18n";
import {Languages} from "../../types/Languages";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import {setLanguage} from "../../redux/actions/authAction";

const LanguageChoice = () => {
    const currentLanguage = useSelector((state: RootState) => state.currentUser).language;
    const dispatch = useDispatch();

    useEffect(() => {
        if (currentLanguage) {
            i18n.changeLanguage(currentLanguage);
        }
    }, [currentLanguage]);

    const handleLanguageChange = (newLanguage: Languages) => {
        dispatch(setLanguage(newLanguage));
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