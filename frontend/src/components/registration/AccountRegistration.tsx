import RegistrationFirstPage from "./RegistrationFirstPage";
import React, { useEffect, useState } from "react";
import { Box, FormControl } from "@mui/material";
import ProgressBar from "../progressBar/ProgressBar";
import { useTranslation } from "react-i18next";
import RegistrationSecondPage from "./RegistrationSecondPage";
import RegistrationThirdPage from "./RegistrationThirdPage";
import BasicButton from "../buttons/BasicButton";
import BackArrow from "../buttons/BackArrow";
import { useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import { RequestData, RequestMethod } from "../../api/RequestData";
import { ApiEndpoints } from "../../api/ApiEndpoints";
import { useNavigate } from "react-router-dom";
import { Roles } from "../../security/Roles";
import { RegistrationValidationPages } from "../../types/registration/RegistrationValidationPages";
import { ALERT_AUTOHIDE } from "../../utils/consts";
import Logo from "../icons/Logo";
import NotificationHandler from "../response/NotificationHandler";

const AccountRegistration = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const registrationData = useSelector(
    (state: RootState) => state.registration,
  );
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;
  const validPages = useSelector(
    (state: RootState) => state.registrationValidations,
  ) as RegistrationValidationPages;
  const amountOfPages = currentRole === Roles.GUEST ? 3 : (2 as number);
  const [currentPage, setCurrentPage] = useState(1);
  const [progress, setProgress] = useState(0);
  const [isOpenConfig, setIsOpenConfig] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);

  const handleGoToNextPage = () => {
    currentPage + 1 > amountOfPages
      ? setCurrentPage(amountOfPages)
      : setCurrentPage(currentPage + 1);
  };

  const handleGoToPreviousPage = () => {
    currentPage - 1 < 1 ? setCurrentPage(1) : setCurrentPage(currentPage - 1);
  };

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.POST,
      endpoint:
        currentRole === Roles.GUEST
          ? ApiEndpoints.CLIENT_REGISTRATION_ENDPOINT
          : ApiEndpoints.ACCOUNT_REGISTRATION_ENDPOINT,
      data: registrationData,
    };
  };

  const success = () => {
    setTimeout(() => {
      currentRole === Roles.GUEST
        ? navigate("/registration-passed")
        : navigate("/accounts");
    }, ALERT_AUTOHIDE);
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpenConfig(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  useEffect(() => {
    setProgress((100 / amountOfPages) * currentPage);
  }, [currentPage, progress, validPages]);

  return (
    <div className="registerContainer">
      <FormControl variant="standard" className="data-container-main">
        <div className="data-container-head-row">
          {currentRole === Roles.GUEST ? (
            <Logo onClick={() => navigate("/")} />
          ) : (
            <h2 className="data-container-head-row-h2 ">
              {t("registration.register")}
            </h2>
          )}

          {currentPage !== (1 as number) && (
            <div
              className="data-container-head-row-rest"
              onClick={handleGoToPreviousPage}
            >
              <BackArrow className="data-container-head-row-rest-arrow" />
              <label className="data-container-head-row-rest-label">
                {t("containers.back")}
              </label>
            </div>
          )}
        </div>
        <ProgressBar progress={progress} />
        {currentPage === 1 && <RegistrationFirstPage />}
        {currentPage === 2 && validPages.firstPage && (
          <RegistrationSecondPage />
        )}
        {currentPage !== 2 &&
          validPages.firstPage &&
          validPages.secondPage &&
          currentPage === amountOfPages && <RegistrationThirdPage />}
        {((currentPage === 1 && validPages.firstPage) ||
          (currentPage === 2 &&
            validPages.firstPage &&
            validPages.secondPage) ||
          (currentPage === 3 &&
            validPages.firstPage &&
            validPages.secondPage &&
            validPages.thirdPage)) && (
          <Box className=" data-container-buttons">
            <BasicButton
              content={
                currentPage === amountOfPages &&
                ((amountOfPages === (2 as number) &&
                  validPages.firstPage &&
                  validPages.secondPage) ||
                  (amountOfPages === 3 &&
                    validPages.firstPage &&
                    validPages.secondPage &&
                    validPages.thirdPage))
                  ? t("buttons.submit")
                  : t("buttons.next")
              }
              onClick={
                currentPage < amountOfPages
                  ? handleGoToNextPage
                  : async () => handleParentIsOpenState(true)
              }
            />
          </Box>
        )}
        {t("registration.mandatory")}
      </FormControl>
      <NotificationHandler
        isOpenConfirm={isOpenConfig}
        onChangeConfirm={handleParentIsOpenState}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={getRequestData()}
        afterSuccessHandling={success}
      />
    </div>
  );
};
export default AccountRegistration;
