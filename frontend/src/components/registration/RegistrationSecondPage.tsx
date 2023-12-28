import {useTranslation} from "react-i18next";
import ContainerRow, {InputType} from "../containers/ContainerRow";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import React, {useEffect, useState} from "react";
import {
    updatePersonalDataDuringRegistration,
    updateBillingDetailsDuringRegistration
} from "../../redux/actions/registrationAction";
import {Roles} from "../../security/Roles";
import {RegistrationValidationPages} from "../../types/registration/RegistrationValidationPages";
import {
    validateFirstname,
    validateLastname,
    validateNipNumber,
    validatePhoneNumber,
    validateRegonNumber
} from "../../utils/regexpValidator";
import {setFirstPageRegistrationStatus} from "../../redux/actions/validationActions";
import {RegistrationData} from "../../types/registration/RegistrationData";

const RegistrationSecondPage = () => {
    const {t} = useTranslation();
    const registrationData = useSelector((state: RootState) => state.registration) as RegistrationData;
    const currentRole = useSelector((state: RootState) => state.currentUser).currentRole;
    const validSecondPage = useSelector((state: RootState) => state.registrationValidations) as RegistrationValidationPages;
    const [validFirstname, setValidFirstname] = useState<boolean>(validateFirstname(registrationData?.personalData?.firstname as string));
    const [validLastname, setValidLastname] = useState<boolean>(validateLastname(registrationData?.personalData?.lastname as string));
    const [validPhoneNumber, setValidPhoneNumber] = useState<boolean>(validatePhoneNumber(registrationData?.personalData?.phoneNumber as string));
    const [validNip, setValidNip] = useState<boolean>(validateNipNumber(registrationData?.billingDetails?.nip as number));
    const [validRegon, setValidRegon] = useState<boolean>(validateRegonNumber(registrationData?.billingDetails?.regon as number));

    const dispatch = useDispatch();

    const handleFirstnameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let firstname = event.target.value;
        setValidFirstname(validateFirstname(firstname));
        dispatch(updatePersonalDataDuringRegistration({firstname: firstname}));
    };

    const handleLastnameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let lastname = event.target.value;
        setValidLastname(validateLastname(lastname));
        dispatch(updatePersonalDataDuringRegistration({lastname: lastname}));
    };

    const handlePhoneNumberChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let phoneNumber = event.target.value;
        setValidPhoneNumber(validatePhoneNumber(phoneNumber));
        dispatch(updatePersonalDataDuringRegistration({phoneNumber: phoneNumber}));
    };

    const handleNipChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let nip = Number(event.target.value);
        setValidNip(validateNipNumber(nip));
        dispatch(updateBillingDetailsDuringRegistration({nip: nip}));
    };

    const handleRegonChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let regon = Number(event.target.value);
        setValidRegon(validateRegonNumber(regon));
        dispatch(updateBillingDetailsDuringRegistration({regon: regon}));
    };

    useEffect(() => {
        const page = {
            firstPage: validSecondPage.firstPage,
            secondPage: validFirstname && validLastname && validPhoneNumber
                && (currentRole === Roles.ADMINISTRATOR ? true : (validNip && validRegon)),
            thirdPage: validSecondPage.thirdPage
        }
        dispatch(setFirstPageRegistrationStatus(page));
    }, [validFirstname, validLastname, validPhoneNumber, validNip, validRegon]);

    return (
        <div>
            <ContainerRow
                placeholder={t('registration.firstname')}
                type={InputType.BASIC}
                onChangeValue={handleFirstnameChange}
                value={registrationData.personalData?.firstname}
                valid={validFirstname}
                validationText={t('validation.placeholder.firstname')}
            />
            <ContainerRow
                placeholder={t('registration.lastname')}
                type={InputType.BASIC}
                onChangeValue={handleLastnameChange}
                value={registrationData.personalData?.lastname}
                valid={validLastname}
                validationText={t('validation.placeholder.lastname')}
            />
            <ContainerRow
                placeholder={t('registration.phoneNumber')}
                type={InputType.BASIC}
                onChangeValue={handlePhoneNumberChange}
                value={registrationData.personalData?.phoneNumber}
                valid={validPhoneNumber}
                validationText={t('validation.placeholder.phoneNumber')}
            />
            {currentRole === Roles.GUEST &&
                <div>
                    <ContainerRow
                        placeholder={t('registration.nip')}
                        type={InputType.BASIC}
                        onChangeValue={handleNipChange}
                        value={registrationData?.billingDetails?.nip}
                        valid={validNip}
                        validationText={t('validation.placeholder.nip')}
                    />
                    <ContainerRow
                        placeholder={t('registration.regon')}
                        type={InputType.BASIC}
                        onChangeValue={handleRegonChange}
                        value={registrationData?.billingDetails?.regon}
                        valid={validRegon}
                        validationText={t('validation.placeholder.regon')}
                    />
                </div>
            }
        </div>
    );
}
export default RegistrationSecondPage;