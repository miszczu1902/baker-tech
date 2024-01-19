import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import { useNavigate, useParams } from "react-router-dom";
import React, { useEffect, useState } from "react";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { DEFAULT_PAGE_SIZE } from "../../../utils/consts";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { ListData } from "../../../types/ListData";
import ContainerRow, { InputType } from "../../containers/ContainerRow";
import {
  Checkbox,
  FormControlLabel,
  Pagination,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@mui/material";
import AddIcon from "@mui/icons-material/Add";
import LoopIcon from "@mui/icons-material/Loop";
import NotificationHandler from "../../response/NotificationHandler";
import { DeviceData } from "../../../types/service/devices/DeviceData";
import { DeviceCategory } from "../../../types/service/devices/DeviceCategory";
import EndDeviceWarranty from "./EndDeviceWarranty";
import { ListProps } from "../../containers/ListProps";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { setDevicesForOrder } from "../../../redux/actions/editOrderActions";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const DevicesList: React.FC<ListProps> = ({ isSubSelectList }) => {
  const { id } = useParams();
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const navigate = useNavigate();
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;
  const devicesForOrder = useSelector((state: RootState) => state.editOrder)
    .forSettlement?.devices as number[];
  const dispatch = useDispatch();
  const [devices, setDevices] = useState<DeviceData[]>();
  const [sortBy, setSortBy] = useState("");
  const [filter, setFilter] = useState<string>("");
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>();
  const [isOpenAlert, setIsOpenAlert] = useState<boolean>(false);
  const [deviceCategory, setDeviceCategory] = useState<string>("");
  const [warrantyEnded, setWarrantyEnded] = useState<boolean>();
  const [warrantyNotEnded, setWarrantyNotEnded] = useState<boolean>();

  const getDevicesData = (): RequestData => {
    console.log(id);
    let queryParams: Record<string, string | number | boolean> = {
      size: DEFAULT_PAGE_SIZE,
      page: currentPage - 1,
    };

    if (sortBy !== "") {
      queryParams.sort = sortBy;
    }

    if (filter !== "") {
      queryParams.serialNumber = filter;
    }

    if (deviceCategory !== "") {
      queryParams.category = deviceCategory;
    }

    if (warrantyEnded) {
      queryParams.warrantyEnded = true;
    }

    if (warrantyNotEnded) {
      queryParams.warrantyEnded = false;
    }

    return {
      method: RequestMethod.GET,
      endpoint: id
        ? ApiEndpoints.GET_DEVICES_FOR_ORDER.replace(":id", id.toString())
        : ApiEndpoints.GET_ALL_DEVICES,
      queryParams: id ? undefined : queryParams,
    };
  };

  const handleParentIsOpenAlertState = (newState: boolean) => {
    setIsOpenAlert(newState);
  };

  const success = (response: any) => {
    setDevices(response.content);
    setTotalPages(response.totalPages);
    setCurrentPage(response.number + 1);
  };

  const handleSortBy = (
    event: React.MouseEvent<HTMLTableCellElement>,
    value: any,
  ) => {
    setSortBy(sortBy === "" ? value : "");
  };

  const handleFilterCategory = (
    event: React.ChangeEvent<HTMLInputElement>,
    category: DeviceCategory,
  ) => {
    setDeviceCategory(event.target.checked ? (category as string) : "");
  };

  const handleWarrantyEnded = (
    event: React.ChangeEvent<HTMLInputElement>,
    value: boolean,
  ) => {
    setWarrantyEnded(event.target.checked ? value : undefined);
  };

  const handleWarrantyNotEnded = (
    event: React.ChangeEvent<HTMLInputElement>,
    value: boolean,
  ) => {
    setWarrantyNotEnded(event.target.checked ? value : undefined);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<ListData<DeviceData>>(getDevicesData())
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [
    deviceCategory,
    sortBy,
    currentPage,
    totalPages,
    filter,
    devicesForOrder,
    warrantyNotEnded,
    warrantyEnded,
  ]);

  return (
    <div
      className={isSubSelectList ? "list-container normal" : "list-container"}
    >
      <div className="list-header-bar">
        {id === undefined && (
          <ContainerRow
            type={InputType.BASIC}
            className="small"
            placeholder={t("tables.search")}
            onChangeValue={(event) => {
              setFilter(event.target.value);
            }}
            value={filter}
          />
        )}
        {id === undefined && (
          <p>
            {[DeviceCategory.MECHANICAL, DeviceCategory.ELECTROMECHANICAL].map(
              (category) => (
                <FormControlLabel
                  key={category}
                  control={
                    <Checkbox
                      key={category}
                      checked={deviceCategory === (category as string)}
                      onChange={(e) => handleFilterCategory(e, category)}
                    />
                  }
                  label={t(`devices.${category.toLowerCase()}`)}
                />
              ),
            )}
            <FormControlLabel
              key={warrantyEnded?.toString()}
              control={
                <Checkbox
                  key={warrantyEnded?.toString()}
                  checked={warrantyEnded}
                  onChange={(e) => handleWarrantyEnded(e, !warrantyEnded)}
                />
              }
              label={t(`orders.warrantyEnded`)}
            />
            <FormControlLabel
              key={warrantyNotEnded?.toString()}
              control={
                <Checkbox
                  key={warrantyNotEnded?.toString()}
                  checked={warrantyNotEnded}
                  onChange={(e) => handleWarrantyNotEnded(e, !warrantyNotEnded)}
                />
              }
              label={t(`orders.warrantyNotEnded`)}
            />
          </p>
        )}
      </div>
      <Table className="list-content">
        <TableHead>
          <TableRow>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "brand")}
            >
              {t("devices.brand")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "deviceName")}
            >
              {t("devices.deviceName")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "category")}
            >
              {t("devices.category")}
            </TableCell>
            <TableCell
              className="list-header"
              onClick={(event) => handleSortBy(event, "serialNumber")}
            >
              {t("devices.serialNumber")}
            </TableCell>
            {!isSubSelectList && (
              <TableCell
                className="list-header"
                onClick={(event) => handleSortBy(event, "warrantyEnded")}
              >
                {t("devices.warrantyEnded")}
              </TableCell>
            )}
          </TableRow>
        </TableHead>
        <TableBody>
          {devices?.map((device) => (
            <TableRow
              key={device.id}
              className={
                isSubSelectList && devicesForOrder?.includes(device.id)
                  ? "list-row selected-row"
                  : "list-row"
              }
              onClick={() => {
                if (isSubSelectList && id === undefined) {
                  dispatch(
                    setDevicesForOrder(
                      !devicesForOrder?.includes(device.id)
                        ? [...devicesForOrder, device.id]
                        : devicesForOrder?.filter((item) => item !== device.id),
                    ),
                  );
                }
              }}
            >
              <TableCell>{device.brand}</TableCell>
              <TableCell>{device.deviceName}</TableCell>
              <TableCell>
                {t(`devices.${device.category.toLowerCase()}`)}
              </TableCell>
              <TableCell>{device.serialNumber}</TableCell>
              {!isSubSelectList && id === undefined && (
                <TableCell>
                  {device.warrantyEnded && t("devices.ended")}
                  {!device.warrantyEnded && (
                    <EndDeviceWarranty id={device.id} />
                  )}
                </TableCell>
              )}
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <div className="list-pagination">
        <Pagination
          page={currentPage}
          count={totalPages}
          onChange={(event, page) => setCurrentPage(page)}
          color="primary"
        />
        {id === undefined && (
          <AddIcon
            className="list-button"
            onClick={() => navigate("/devices/add")}
          />
        )}
        <LoopIcon
          className="list-button"
          onClick={(event) =>
            requestService
              .sendRequestAndGetResponse<ListData<DeviceData>>(getDevicesData())
              .then(success)
          }
        />
      </div>
      <NotificationHandler
        isOpenConfirm={false}
        onChangeConfirm={() => {}}
        isOpenAlert={isOpenAlert}
        onChangeAlert={handleParentIsOpenAlertState}
        requestData={getDevicesData()}
        afterSuccessHandling={success}
        message={undefined}
      />
    </div>
  );
};
export default DevicesList;
