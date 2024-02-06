import { useTranslation } from "react-i18next";
import { RequestService } from "../../../api/RequestService";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import React, { useEffect, useState } from "react";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import { ListData } from "../../../types/ListData";
import {
  Pagination,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@mui/material";
import Typography from "@mui/material/Typography";
import LoopIcon from "@mui/icons-material/Loop";
import { ClientDevicesData } from "../../../types/reports/ClientDevicesData";
import { DEFAULT_PAGE_SIZE } from "../../../utils/consts";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const ClientDevicesReport = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const [devices, setDevices] = useState<ClientDevicesData[]>();
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>();

  const getDevicesDataRequest = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.CLIENT_DEVICES,
      queryParams: {
        size: DEFAULT_PAGE_SIZE,
        page: currentPage - 1,
        year: date.year,
        month: date.month,
      },
    };
  };

  const success = (response: any) => {
    setDevices(response.content);
    setTotalPages(response.totalPages);
    setCurrentPage(response.number + 1);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<ListData<ClientDevicesData>>(
        getDevicesDataRequest(),
      )
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(false));
      });
  }, [date, currentPage, totalPages]);

  return (
    <div className="param-content list">
      <Table className="list-content">
        <TableHead>
          <Typography className="param-content-title">
            {t("reports.client.devices")}
          </Typography>
          <TableRow>
            <TableCell className="list-header" />
            <TableCell className="list-header" />
            <TableCell className="list-header" />
            <TableCell className="list-header" />
          </TableRow>
        </TableHead>
        <TableBody>
          {devices?.map((device) => (
            <TableRow key={device?.serialNumber} className="list-row">
              <TableCell>{device.serialNumber}</TableCell>
              <TableCell>
                {t(`devices.${device?.category.toString().toLowerCase()}`)}
              </TableCell>
              <TableCell>{device.brand}</TableCell>
              <TableCell>{device.deviceName}</TableCell>
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
        <LoopIcon
          className="list-button"
          onClick={(event) =>
            requestService
              .sendRequestAndGetResponse<
                ListData<ClientDevicesData>
              >(getDevicesDataRequest())
              .then(success)
          }
        />
      </div>
    </div>
  );
};
export default ClientDevicesReport;
