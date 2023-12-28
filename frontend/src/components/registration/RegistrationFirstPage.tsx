import ContainerRow, {InputType} from "../containers/ContainerRow";
import {useTranslation} from "react-i18next";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import React, {useEffect, useState} from "react";
import {updateBasicRegistrationData} from "../../redux/actions/registrationAction";
import {
    validateCompanyName,
    validateConfirmPassword,
    validateEmail,
    validatePassword,
    validateUsername
} from "../../utils/regexpValidator";
import {setFirstPageRegistrationStatus} from "../../redux/actions/validationActions";
import {RegistrationValidationPages} from "../../types/registration/RegistrationValidationPages";
import {RegistrationData} from "../../types/registration/RegistrationData";
import {Roles} from "../../security/Roles";

const RegistrationFirstPage = () => {
    const {t} = useTranslation();
    const registrationData = useSelector((state: RootState) => state.registration) as RegistrationData;
    const currentPassword = useSelector((state: RootState) => state.registration).password;
    const validFirstPage = useSelector((state: RootState) => state.registrationValidations) as RegistrationValidationPages;
    const currentRole = useSelector((state: RootState) => state.currentUser).currentRole;
    const dispatch = useDispatch();
    const [validUsername, setValidUsername] = useState<boolean>(validateUsername(registrationData.username as string));
    const [validPassword, setValidPassword] = useState<boolean>(validatePassword(registrationData.password as string));
    const [confirmPassword, setConfirmPassword] = useState<string>(registrationData.password as string);
    const [validConfirmPassword, setValidConfirmPassword] = useState<boolean>(validateConfirmPassword(confirmPassword, registrationData.password as string));
    const [validEmail, setValidEmail] = useState<boolean>(validateEmail(registrationData.email as string));
    const [validCompanyName, setValidCompanyName] = useState<boolean>(validateCompanyName(registrationData.companyName as string));

    const handleUsernameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let username = event.target.value;
        setValidUsername(validateUsername(username));
        dispatch(updateBasicRegistrationData({username: username}));
    };

    const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let password = event.target.value;
        setValidPassword(validatePassword(password));
        dispatch(updateBasicRegistrationData({password: password}));
    };

    const handleConfirmPasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let password = event.target.value;
        setConfirmPassword(password);
        setValidConfirmPassword(validateConfirmPassword(currentPassword, password));
    };

    const handleEmailChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let email = event.target.value;
        setValidEmail(validateEmail(email))
        dispatch(updateBasicRegistrationData({email: email}));
    };

    const handleCompanyNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let companyName = event.target.value;
        setValidCompanyName(validateCompanyName(companyName));
        dispatch(updateBasicRegistrationData({companyName: companyName}));
    };

    useEffect(() => {
        const page = {
            firstPage: currentRole === Roles.GUEST
                ? validUsername && validPassword && validConfirmPassword && validCompanyName && validEmail
            : validUsername && validEmail,
            secondPage: validFirstPage.secondPage,
            thirdPage: validFirstPage.thirdPage
        }
        dispatch(setFirstPageRegistrationStatus(page));
    }, [confirmPassword, validUsername, validPassword, validEmail, validConfirmPassword, validCompanyName]);

    return (
        <div>
            <ContainerRow
                placeholder={t('registration.username')}
                type={InputType.BASIC}
                onChangeValue={handleUsernameChange}
                value={registrationData.username}
                valid={validUsername}
                validationText={t('validation.placeholder.username')}
            />
            <ContainerRow
                placeholder={t('registration.email')}
                type={InputType.BASIC}
                onChangeValue={handleEmailChange}
                value={registrationData.email}
                valid={validEmail}
                validationText={t('validation.placeholder.email')}
            />
            {currentRole === Roles.GUEST && <div>
                <ContainerRow
                    placeholder={t('registration.password')}
                    type={InputType.PASSWORD}
                    onChangeValue={handlePasswordChange}
                    value={registrationData.password}
                    valid={validPassword}
                    validationText={t('validation.placeholder.password')}
                />
                <ContainerRow
                    placeholder={t('registration.confirm')}
                    type={InputType.PASSWORD}
                    onChangeValue={handleConfirmPasswordChange}
                    value={confirmPassword}
                    valid={validConfirmPassword}
                    validationText={t('validation.placeholder.confirm')}
                />
                <ContainerRow
                    placeholder={t('registration.companyName')}
                    type={InputType.BASIC}
                    onChangeValue={handleCompanyNameChange}
                    value={registrationData.companyName}
                    valid={validCompanyName}
                    validationText={t('validation.placeholder.companyName')}
                />
            </div>}
        </div>
    );
}
export default RegistrationFirstPage;