import {useTranslation} from "react-i18next";
import ContainerRow, {InputType} from "../containers/ContainerRow";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "../../redux/store";
import React from "react";
import {updateAddressDuringRegistration} from "../../redux/actions/registrationAction";

const RegistrationThirdPage = () => {
    const {t} = useTranslation();
    const registrationData = useSelector((state: RootState) => state.registration);
    const dispatch = useDispatch();

    const handleStreetChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let street = event.target.value;
        dispatch(updateAddressDuringRegistration({street: street}));
    };

    const handleStreetNumberChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let streetNumber = event.target.value;
        dispatch(updateAddressDuringRegistration({streetNumber: streetNumber}));
    };

    const handlePostalCodeChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let postalCode = event.target.value;
        dispatch(updateAddressDuringRegistration({postalCode: postalCode}));
    };

    const handleCityChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        let city = event.target.value;
        dispatch(updateAddressDuringRegistration({city: city}));
    };
    return (
        <div>
            <ContainerRow
                placeholder={t('registration.street')}
                type={InputType.BASIC}
                onChangeValue={handleStreetChange}
                value={registrationData.address?.street}
            />
            <ContainerRow
                placeholder={t('registration.streetNumber')}
                type={InputType.PASSWORD}
                onChangeValue={handleStreetNumberChange}
                value={registrationData.address?.streetNumber}
            />
            <ContainerRow
                placeholder={t('registration.postalCode')}
                type={InputType.BASIC}
                onChangeValue={handlePostalCodeChange}
                value={registrationData.address?.postalCode}
            />
            <ContainerRow
                placeholder={t('registration.city')}
                type={InputType.BASIC}
                onChangeValue={handleCityChange}
                value={registrationData.address?.city}
            />
        </div>
    );
}
export default RegistrationThirdPage;