import { useTranslation } from "react-i18next";
import ContainerRow, { InputType } from "../containers/ContainerRow";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import React, { useEffect, useState } from "react";
import { updateAddressDuringRegistration } from "../../redux/actions/registrationActions";
import { RegistrationValidationPages } from "../../types/registration/RegistrationValidationPages";
import {
  setFirstPageRegistrationStatus,
  setThirdPageRegistrationStatus,
} from "../../redux/actions/validationActions";
import {
  validateCity,
  validatePostalCode,
  validateStreet,
  validateStreetNumber,
} from "../../utils/regexpValidator";
import { RegistrationData } from "../../types/registration/RegistrationData";

const RegistrationThirdPage = () => {
  const { t } = useTranslation();
  const registrationData = useSelector(
    (state: RootState) => state.registration,
  ) as RegistrationData;
  const validThirdPage = useSelector(
    (state: RootState) => state.registrationValidations,
  ) as RegistrationValidationPages;
  const [validStreet, setValidStreet] = useState<boolean>(
    validateStreet(registrationData.address?.street as string),
  );
  const [validStreetNumber, setValidStreetNumber] = useState<boolean>(
    validateStreetNumber(registrationData.address?.streetNumber as string),
  );
  const [validPostalCode, setValidPostalCode] = useState<boolean>(
    validatePostalCode(registrationData.address?.postalCode as string),
  );
  const [validCity, setValidCity] = useState<boolean>(
    validateCity(registrationData.address?.city as string),
  );
  const dispatch = useDispatch();

  const handleStreetChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    let street = event.target.value;
    setValidStreet(validateStreet(street));
    dispatch(updateAddressDuringRegistration({ street: street }));
  };

  const handleStreetNumberChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    let streetNumber = event.target.value;
    setValidStreetNumber(validateStreetNumber(streetNumber));
    dispatch(updateAddressDuringRegistration({ streetNumber: streetNumber }));
  };

  const handlePostalCodeChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    let postalCode = event.target.value;
    setValidPostalCode(validatePostalCode(postalCode));
    dispatch(updateAddressDuringRegistration({ postalCode: postalCode }));
  };

  const handleCityChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    let city = event.target.value;
    setValidCity(validateCity(city));
    dispatch(updateAddressDuringRegistration({ city: city }));
  };

  useEffect(() => {
    const page = {
      firstPage: validThirdPage.firstPage,
      secondPage: validThirdPage.secondPage,
      thirdPage:
        validStreet && validStreetNumber && validPostalCode && validCity,
    };
    dispatch(setThirdPageRegistrationStatus(page));
  }, [validStreet, validStreetNumber, validPostalCode, validCity]);

  return (
    <div>
      <ContainerRow
        placeholder={t("registration.street")}
        type={InputType.BASIC}
        onChangeValue={handleStreetChange}
        value={registrationData.address?.street}
        valid={validStreet}
        validationText={t("validation.placeholder.street")}
      />
      <ContainerRow
        placeholder={t("registration.streetNumber")}
        type={InputType.BASIC}
        onChangeValue={handleStreetNumberChange}
        value={registrationData.address?.streetNumber}
        valid={validStreetNumber}
        validationText={t("validation.placeholder.streetNumber")}
      />
      <ContainerRow
        placeholder={t("registration.postalCode")}
        type={InputType.BASIC}
        onChangeValue={handlePostalCodeChange}
        value={registrationData.address?.postalCode}
        valid={validPostalCode}
        validationText={t("validation.placeholder.postalCode")}
      />
      <ContainerRow
        placeholder={t("registration.city")}
        type={InputType.BASIC}
        onChangeValue={handleCityChange}
        value={registrationData.address?.city}
        valid={validCity}
        validationText={t("validation.placeholder.city")}
      />
    </div>
  );
};
export default RegistrationThirdPage;
