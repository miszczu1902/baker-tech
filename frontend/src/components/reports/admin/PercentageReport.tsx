import { RequestService } from "../../../api/RequestService";
import { RequestData, RequestMethod } from "../../../api/RequestData";
import React, { useEffect, useState } from "react";
import { PieChartReportData } from "../../../types/reports/PieChartReportData";
import { PieChart } from "@mui/x-charts/PieChart";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { Box } from "@mui/material";
import Typography from "@mui/material/Typography";
import ReportDates from "../ReportDates";
import {
  setOpenAlert,
  setOpenConfirm,
} from "../../../redux/actions/notificationActions";

interface PercentageReportProps {
  path: string;
}

const PercentageReport: React.FC<PercentageReportProps> = ({ path }) => {
  const { t } = useTranslation();
  const requestService = RequestService.getInstance();
  const dispatch = useDispatch();
  const date = useSelector((state: RootState) => state.reportPeriod);
  const [pieChartData, setPieChartData] = useState<PieChartReportData>();

  const getRequestData = (): RequestData => {
    return {
      method: RequestMethod.GET,
      endpoint: path,
      queryParams: {
        year: date.year,
        month: date.month,
      },
    };
  };

  useEffect(() => {
    requestService
      .sendRequestAndGetResponse<PieChartReportData>(getRequestData())
      .then((response) => setPieChartData(response))
      .catch(() => {
        dispatch(setOpenConfirm(false));
        dispatch(setOpenAlert(false));
      });
  }, [date]);

  return (
    <Box className="param-content" flexGrow={1}>
      <Typography className="param-content-title">
        {t("reports.admin.percentage")}
        <ReportDates />
      </Typography>
      <PieChart
        className="pie-chart"
        width={600}
        height={250}
        series={[
          {
            data: [
              {
                value: pieChartData?.nonWarrantyRepair as number,
                color: "red",
                label: `${t("orders.ordersQueue.non_warranty_repair")}`,
              },
              {
                value: pieChartData?.warrantyRepair as number,
                color: "orange",
                label: `${t("orders.ordersQueue.warranty_repair")}`,
              },
              {
                value: pieChartData?.conservation as number,
                color: "green",
                label: `${t("orders.ordersQueue.conservation")}`,
              },
            ],
            innerRadius: 30,
            outerRadius: 100,
            paddingAngle: 0,
            cornerRadius: 5,
          },
        ]}
      />
    </Box>
  );
};
export default PercentageReport;
