import ContainerRow, {InputType} from "../containers/ContainerRow";
import {useTranslation} from "react-i18next";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import React from "react";
import {updateBasicRegistrationData} from "../../redux/actions/registrationAction";
import ContainerSelect from "../containers/ContainerSelect";

const RegistrationFirstPage = () => {
    const {t} = useTranslation();
    const registrationData = useSelector((state: RootState) => state.registration);
    const dispatch = useDispatch();

    const handleUsernameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let username = event.target.value;
        dispatch(updateBasicRegistrationData({username: username}));
    };

    const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let password = event.target.value;
        dispatch(updateBasicRegistrationData({password: password}));
    };

    const handleEmailChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let email = event.target.value;
        dispatch(updateBasicRegistrationData({email: email}));
    };

    const handleCompanyNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let companyName = event.target.value;
        dispatch(updateBasicRegistrationData({companyName: companyName}));
    };

    return (
        <div>
            <ContainerRow
                placeholder={t('registration.username')}
                type={InputType.BASIC}
                onChangeValue={handleUsernameChange}
                value={registrationData.username}
            />
            <ContainerRow
                placeholder={t('registration.password')}
                type={InputType.PASSWORD}
                onChangeValue={handlePasswordChange}
                value={registrationData.password}
            />
            <ContainerRow
                placeholder={t('registration.email')}
                type={InputType.BASIC}
                onChangeValue={handleEmailChange}
                value={registrationData.email}
            />
            <ContainerRow
                placeholder={t('registration.companyName')}
                type={InputType.BASIC}
                onChangeValue={handleCompanyNameChange}
                value={registrationData.companyName}
            />
            <ContainerSelect/>
            {/*<ContainerRow*/}
            {/*    placeholder={t('registration.defaultLanguage')}*/}
            {/*    type={InputType.BASIC}*/}
            {/*/>*/}
        </div>
    );
}
export default RegistrationFirstPage;