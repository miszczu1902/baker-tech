import i18n from "i18next";
import {initReactI18next} from "react-i18next";
import LanguageDetector from "i18next-browser-languagedetector";
import HttpApi from "i18next-http-backend";
import plTranslation from "./translations/pl/pl.json";
import enTranslation from "./translations/en/en.json";
import {Languages} from "./types/Languages";

export const resources = {
    pl: {
        translation: plTranslation
    },
    en: {
        translation: enTranslation
    }
};

i18n
    .use(initReactI18next)
    .use(LanguageDetector)
    .use(HttpApi)
    .init({
        resources,
        fallbackLng: Languages.pl,
        detection: {
            order: ["localStorage", "cookie", "htmlTag", "path", "subdomain"],
            caches: ["localStorage", "cookie"],
        }
    });

export default i18n;

