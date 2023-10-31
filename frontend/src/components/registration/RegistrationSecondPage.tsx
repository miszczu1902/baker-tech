import {useTranslation} from "react-i18next";
import ContainerRow, {InputType} from "../containers/ContainerRow";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import React from "react";
import {updatePersonalDataDuringRegistration, updateBillingDetailsDuringRegistration} from "../../redux/actions/registrationAction";

const RegistrationSecondPage = () => {
    const {t} = useTranslation();
    const registrationData = useSelector((state: RootState) => state.registration);
    const dispatch = useDispatch();

    const handleFirstnameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let firstname = event.target.value;
        dispatch(updatePersonalDataDuringRegistration({firstname: firstname}));
    };

    const handleLastnameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let lastname = event.target.value;
        dispatch(updatePersonalDataDuringRegistration({lastname: lastname}));
    };

    const handlePhoneNumberChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let phoneNumber = event.target.value;
        dispatch(updatePersonalDataDuringRegistration({phoneNumber: phoneNumber}));
    };

    const handleNipChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let nip = Number(event.target.value);
        dispatch(updateBillingDetailsDuringRegistration({nip: nip}));
    };

    const handleRegonChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let regon = Number(event.target.value);
        dispatch(updateBillingDetailsDuringRegistration({regon: regon}));
    };
    return (
        <div>
            <ContainerRow
                placeholder={t('registration.firstname')}
                type={InputType.BASIC}
                onChangeValue={handleFirstnameChange}
                value={registrationData.personalData?.firstname}
            />
            <ContainerRow
                placeholder={t('registration.lastname')}
                type={InputType.BASIC}
                onChangeValue={handleLastnameChange}
                value={registrationData.personalData?.lastname}
            />
            <ContainerRow
                placeholder={t('registration.phoneNumber')}
                type={InputType.BASIC}
                onChangeValue={handlePhoneNumberChange}
                value={registrationData.personalData?.phoneNumber}
            />
            <ContainerRow
                placeholder={t('registration.nip')}
                type={InputType.BASIC}
                onChangeValue={handleNipChange}
                value={registrationData.billingDetails?.nip}
            />
            <ContainerRow
                placeholder={t('registration.regon')}
                type={InputType.BASIC}
                onChangeValue={handleRegonChange}
                value={registrationData.billingDetails?.regon}
            />
        </div>
    );
}
export default RegistrationSecondPage;