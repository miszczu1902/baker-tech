import { Box, Container } from "@mui/material";
import Logo from "../icons/Logo";
import { useNavigate } from "react-router-dom";
import { Roles } from "../../security/Roles";
import { useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import Sidebar from "./sidebar/Sidebar";
import React from "react";
import AccessLevelSwitch from "./sidebar/AccessLevelSwitch";

const DefaultMenu = () => {
  const navigate = useNavigate();
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;
  const currentUser = useSelector(
    (state: RootState) => state.currentUser,
  ).currentUser;

  return (
    <Box className="default-navbar">
      <Container className="default-navbar-logo">
        {currentRole !== Roles.GUEST && <Sidebar />}
      </Container>
      <Container className="center user-data">
        {currentRole !== Roles.GUEST && <p className="sidebar-text">{currentUser}</p>}
      </Container>
      <Container className="center user-data">
        {currentRole !== Roles.GUEST && <AccessLevelSwitch/>}
      </Container>
      <Container className="default-navbar-section">
        <Logo onClick={() => navigate("/")} />
      </Container>
    </Box>
  );
};
export default DefaultMenu;
