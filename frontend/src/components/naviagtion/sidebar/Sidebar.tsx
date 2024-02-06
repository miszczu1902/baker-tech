import React, { useState } from "react";
import { Drawer, IconButton, List, ListItemButton } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { useSelector } from "react-redux";
import MenuIcon from "@mui/icons-material/Menu";
import { useTranslation } from "react-i18next";
import { RootState } from "../../../redux/store";
import BackArrow from "../../buttons/BackArrow";
import LanguageChoice from "../LanguageChoice";
import { Roles } from "../../../security/Roles";
import Breadcrumb from "../Breadcrumb";
import LogoutButton from "../LogoutButton";

const Sidebar = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;
  const [open, setOpen] = useState(false);
  const [selectedItem, setSelectedItem] = useState("");

  const toggleDrawer = () => {
    setOpen(!open);
  };

  const closeDrawer = () => {
    setOpen(false);
    setSelectedItem("");
  };

  const handleItemClick = (itemName: string) => {
    setSelectedItem(itemName);
    setOpen(!open);
    navigate(["admin", "serviceman", "client"].includes(itemName) ? '/' : itemName);
  };

  const menuItems = (): string[] => {
    switch (currentRole) {
      case Roles.ADMINISTRATOR:
        return ["admin", "self", "accounts", "queue", "orders", "devices", "settings"];
      case Roles.SERVICEMAN:
        return ["serviceman", "self", "queue", "orders", "order", "devices"];
      case Roles.CLIENT:
        return ["client", "self", "orders", "order"];
      default:
        return [];
    }
  };

  return (
    <div className="sidebar-container">
      <Drawer variant="persistent" anchor="left" open={open}>
        <div className="sidebar-head">
          <div className="sidebar-arrow">
            <BackArrow onClick={closeDrawer} />
            <LanguageChoice />
          </div>
          <List className="sidebar-drawer">
            {menuItems().map((item) => (
              <ListItemButton
                className="sidebar-list-item"
                key={item}
                selected={selectedItem === item}
                onClick={() => handleItemClick(item)}
              >
                {t(`sidebar.${item}`)}
              </ListItemButton>
            ))}
          </List>
        </div>
        <Breadcrumb />
        <LogoutButton />
      </Drawer>
      <div className="sidebar-content">
        <IconButton
          edge="start"
          color="inherit"
          aria-label="menu"
          onClick={toggleDrawer}
        >
          <MenuIcon className="sidebar-menu-icon" />
        </IconButton>
      </div>
    </div>
  );
};
export default Sidebar;
