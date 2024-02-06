import { useTranslation } from "react-i18next";
import React, { useEffect, useState } from "react";
import { validateDeviceDataField, validateSerialNumber } from "../../../utils/regexpValidator";
import ContainerRow, { InputType } from "../../containers/ContainerRow";
import { AddDeviceData } from "../../../types/service/devices/AddDeviceData";
import NotificationHandler from "../../response/NotificationHandler";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import BasicButton from "../../buttons/BasicButton";
import { Checkbox, FormControl, FormControlLabel } from "@mui/material";
import { DeviceCategory } from "../../../types/service/devices/DeviceCategory";
import { useNavigate } from "react-router-dom";

const AddDevice = () => {
  const { t } = useTranslation();
  const [validDeviceName, setValidDeviceName] = useState<boolean>(false);
  const [validBrand, setValidBrand] = useState<boolean>(false);
  const [validSerialNumber, setValidSerialNumber] = useState<boolean>(false);
  const [deviceCategory, setDeviceCategory] = useState<DeviceCategory>(
    DeviceCategory.MECHANICAL,
  );
  const [warrantyEnded, setWarrantyEnded] = useState<boolean>(false);
  const [isOpenConfig, setIsOpenConfig] = useState<boolean>(false);
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);
  const [validAllData, setValidAllData] = useState<boolean>(false);
  const [device, setDevice] = useState<AddDeviceData>({
    warrantyEnded: warrantyEnded,
    category: deviceCategory,
  });

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.POST,
      endpoint: ApiEndpoints.GET_ALL_DEVICES,
      data: device,
    };
  };

  const handleDeviceNameChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    let deviceName = event.target.value;
    setValidDeviceName(validateDeviceDataField(deviceName));
    setDevice((prevDevice) => ({
      ...prevDevice,
      deviceName: deviceName,
    }));
  };

  const handleBrandChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    let brand = event.target.value;
    setValidBrand(validateDeviceDataField(brand));
    setDevice((prevDevice) => ({
      ...prevDevice,
      brand: brand,
    }));
  };

  const handleSerialNumberChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    let serialNumber = event.target.value;
    setValidSerialNumber(validateSerialNumber(serialNumber));
    setDevice((prevDevice) => ({
      ...prevDevice,
      serialNumber: serialNumber,
    }));
  };

  const handleCategoryChange = (
    event: React.ChangeEvent<HTMLInputElement>,
    category: DeviceCategory,
  ) => {
    setDeviceCategory(category);
    setDevice((prevDevice) => ({
      ...prevDevice,
      category: category,
    }));
  };

  const handleWarrantyChange = (
    event: React.ChangeEvent<HTMLInputElement>,
    warrantyEnded: boolean,
  ) => {
    setWarrantyEnded(warrantyEnded);
    setDevice((prevDevice) => ({
      ...prevDevice,
      warrantyEnded: warrantyEnded,
    }));
  };

  const handleParentIsOpenState = (newState: boolean) => {
    setIsOpenConfig(newState);
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const success = (arg: any) => {
    handleParentIsOpenAlertState(true);
    setValidDeviceName(false);
    setValidBrand(false);
    setValidSerialNumber(false);
    setDeviceCategory(DeviceCategory.MECHANICAL);
    setValidDeviceName(false);
    setWarrantyEnded(false);
  };

  useEffect(() => {
    setValidAllData(
      validDeviceName &&
        validBrand &&
        validSerialNumber &&
        deviceCategory !== undefined,
    );
  }, [
    validDeviceName,
    validBrand,
    validSerialNumber,
    deviceCategory,
    warrantyEnded,
  ]);

  return (
    <div>
      <FormControl variant="standard" className="data-container-main">
        <div className="data-container-head-row">
          <h2 className="data-container-head-row-h2 ">{t("devices.add")}</h2>
        </div>
        <div>
          <ContainerRow
            placeholder={`${t("devices.deviceName")}*`}
            type={InputType.BASIC}
            onChangeValue={handleDeviceNameChange}
            value={device.deviceName}
            valid={validDeviceName}
            validationText={t("validation.placeholder.deviceName")}
          />
          <ContainerRow
            placeholder={`${t("devices.brand")}*`}
            type={InputType.BASIC}
            onChangeValue={handleBrandChange}
            value={device.brand}
            valid={validSerialNumber}
            validationText={t("validation.placeholder.brand")}
          />
          <ContainerRow
            placeholder={`${t("devices.serialNumber")}*`}
            type={InputType.BASIC}
            onChangeValue={handleSerialNumberChange}
            value={device.serialNumber}
            valid={validSerialNumber}
            validationText={t("validation.placeholder.serialNumber")}
          />
        </div>
        <div>
          <p>
            {[DeviceCategory.MECHANICAL, DeviceCategory.ELECTROMECHANICAL].map(
              (category) => (
                <FormControlLabel
                  key={category}
                  control={
                    <Checkbox
                      key={category}
                      checked={deviceCategory === (category as string)}
                      onChange={(e) => handleCategoryChange(e, category)}
                    />
                  }
                  label={t(`devices.${category.toLowerCase()}`)}
                />
              ),
            )}
            {[true, false].map((value) => (
              <FormControlLabel
                key={value.toString()}
                control={
                  <Checkbox
                    key={value.toString()}
                    checked={warrantyEnded === (value as boolean)}
                    onChange={(e) => handleWarrantyChange(e, value)}
                  />
                }
                label={t(`devices.${value ? "end" : "no"}`)}
              />
            ))}
            {validAllData && (
              <BasicButton
                content={t("buttons.submit")}
                onClick={() => {
                  handleParentIsOpenState(true);
                  handleParentIsOpenAlertState(false);
                }}
              />
            )}
          </p>
          <p>{t("registration.mandatory")}</p>
        </div>
        <NotificationHandler
          isOpenConfirm={isOpenConfig}
          onChangeConfirm={handleParentIsOpenState}
          isOpenAlert={isOpenAlert}
          onChangeAlert={handleParentIsOpenAlertState}
          requestData={getRequestData()}
          afterSuccessHandling={success}
        />
      </FormControl>
    </div>
  );
};
export default AddDevice;
