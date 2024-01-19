import { Box } from "@mui/material";
import PercentageReport from "./admin/PercentageReport";
import ServiceParameters from "../service/parameters/ServiceParameters";
import OrdersInPeriod from "./admin/OrdersInPeriod";
import { useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import { Roles } from "../../security/Roles";
import ServicemanSelfReport from "./serviceman/ServicemanSelfReport";
import { ApiEndpoints } from "../../api/ApiEndpoints";
import React from "react";
import ClientDevicesReport from "./client/ClientDevicesReport";
import ClientSelfReport from "./client/ClientSelfReport";
import ServicemanReport from "./admin/ServicemanReport";

const Dashboard = () => {
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;

  return (
    <Box className="data-display-dashboard">
      {currentRole === Roles.ADMINISTRATOR && (
        <Box className="row">
          <OrdersInPeriod />
          <PercentageReport path={ApiEndpoints.ADMIN_REPORT_PERCENTAGE} />
          <ServicemanReport />
        </Box>
      )}
      {currentRole === Roles.SERVICEMAN && (
        <Box className="row">
          <PercentageReport path={ApiEndpoints.SERVICEMAN_REPORT_PERCENTAGE} />
          <ServicemanSelfReport />
        </Box>
      )}
      {currentRole === Roles.CLIENT && (
        <Box className="row">
          <ClientSelfReport />
          <PercentageReport path={ApiEndpoints.CLIENT_REPORT_PERCENTAGE} />
          <ClientDevicesReport />
        </Box>
      )}
    </Box>
  );
};
export default Dashboard;
