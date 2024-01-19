import { RequestService } from "../../../api/RequestService";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import { ApiEndpoints } from "../../../api/ApiEndpoints";
import React, { useEffect, useState } from "react";
import { ServiceParameter } from "../../../types/service/parameters/ServiceParameter";
import { Box, Table, TableBody, TableCell, TableRow } from "@mui/material";
import { useTranslation } from "react-i18next";
import EditServiceParameter from "./EditServiceParameter";
import LoopIcon from "@mui/icons-material/Loop";
import Typography from "@mui/material/Typography";
import { useDispatch, useSelector } from "react-redux";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";
import { RootState } from "../../../redux/store";
import { setNewServiceParameterValue } from "../../../redux/actions/parameterActions";

const ServiceParameters = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const parameterValue = useSelector(
    (state: RootState) => state.serviceParams,
  ).value;
  const [serviceParameters, setServiceParameters] =
    useState<ServiceParameter[]>();

  const getServiceParameters = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.GET_ALL_PARAMS,
    };
  };

  const success = (arg: any) => {
    setServiceParameters(arg);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<ServiceParameter[]>(getServiceParameters())
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(true));
      });
  }, [parameterValue]);

  return (
    <Box flexGrow={1} className="param-content single-window">
      <Typography className="param-content-title">
        {t("admin.title")}
      </Typography>
      <Table className="table-single">
        <TableBody>
          {serviceParameters?.map((parameter) => (
            <TableRow key={parameter.id}>
              <TableCell className="param-content-item">
                {t(`admin.${parameter.serviceParameterType.toLowerCase()}`)}
              </TableCell>
              <TableCell className="param-content-item">
                {parameter.value}
              </TableCell>
              <TableCell className="param-content-item">
                <EditServiceParameter
                  id={parameter.id}
                  value={parameter.value}
                />
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <LoopIcon
        className="list-button"
        onClick={(event) =>
          requestService
            .sendRequestAndGetResponse<
              ServiceParameter[]
            >(getServiceParameters())
            .then(success)
        }
      />
    </Box>
  );
};
export default ServiceParameters;
