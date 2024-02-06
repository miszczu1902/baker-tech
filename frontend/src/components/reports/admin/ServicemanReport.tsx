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
import LoopIcon from "@mui/icons-material/Loop";
import { TextWithNumberReportData } from "../../../types/reports/TextWithNumberReportData";
import Typography from "@mui/material/Typography";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

const ServicemanReport = () => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const [accounts, setAccounts] = useState<TextWithNumberReportData[]>();
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>();

  const getAccountsData = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: ApiEndpoints.ADMIN_SERVICEMAN_REPORT,
      queryParams: {
        size: 2,
        page: currentPage - 1,
        year: date.year,
        month: date.month,
      },
    };
  };

  const success = (response: any) => {
    setAccounts(response.content);
    setTotalPages(response.totalPages);
    setCurrentPage(response.number + 1);
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<ListData<TextWithNumberReportData>>(
        getAccountsData(),
      )
      .then(success)
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(false));
      });
  }, [date, currentPage, totalPages]);

  return (
    <div className="param-content">
      <Table className="list-content">
        <Typography className="param-content-title">
          {t("reports.admin.orders")}
        </Typography>
        <TableBody>
          {accounts?.map((account) => (
            <TableRow key={account.content} className="list-row">
              <TableCell>{account.content}</TableCell>
              <TableCell>{account.value}</TableCell>
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
                ListData<TextWithNumberReportData>
              >(getAccountsData())
              .then(success)
          }
        />
      </div>
    </div>
  );
};
export default ServicemanReport;
