import React, {useState} from "react";
import {Drawer, IconButton, List, ListItemButton} from "@mui/material";
import {useNavigate} from "react-router-dom";
import {useSelector} from "react-redux";
import MenuIcon from '@mui/icons-material/Menu';
import {useTranslation} from "react-i18next";
import {RootState} from "../../../redux/store";
import LogoutButton from "../LogoutButton";
import BackArrow from "../../buttons/BackArrow";
import LanguageChoice from "../LanguageChoice";
import {Roles} from "../../../security/Roles";
import AccessLevelSwitch from "./AccessLevelSwitch";
import Breadcrumb from "../Breadcrumb";

const Sidebar = () => {
    const {t} = useTranslation();
    const navigate = useNavigate();
    const currentUser = useSelector((state: RootState) => state.currentUser).currentUser;
    const currentRole = useSelector((state: RootState) => state.currentUser).currentRole;
    const [open, setOpen] = useState(false);
    const [selectedItem, setSelectedItem] = useState('');

    const toggleDrawer = () => {
        setOpen(!open);
    };

    const closeDrawer = () => {
        setOpen(false);
        setSelectedItem('');
    };

    const handleItemClick = (itemName: string) => {
        setSelectedItem(itemName);
        setOpen(!open);
        navigate(itemName);
    };

    const menuItems = (): string[] => {
        switch (currentRole) {
            case (Roles.ADMINISTRATOR):
                return ["self", "accounts", "servicemen", "clients", "reports", "queue", "orders", "devices"];
            case (Roles.SERVICEMAN):
                return ["self", "clients", "reports", "queue", "orders", "order", "devices"];
            case (Roles.CLIENT):
                return ["self", "reports", "orders", "order"];
            default:
                return [];
        }
    };

    return (
        <div className="sidebar-container">
            <Drawer
                variant="persistent"
                anchor="left"
                open={open}
            >
                <div className="sidebar-head">
                    <div className="sidebar-arrow">
                        <BackArrow onClick={closeDrawer}/>
                        <LanguageChoice/>
                    </div>
                    <List className="sidebar-drawer">
                        {menuItems().map(item =>
                            <ListItemButton
                            className="sidebar-list-item"
                            key={item}
                            selected={selectedItem === item}
                            onClick={() => handleItemClick(item)}>
                        {t(`sidebar.${item}`)}
                            </ListItemButton>
                        )}
                    </List>
                </div>
                <Breadcrumb/>
                <p className="sidebar-text">{currentUser}</p>
                <AccessLevelSwitch/>
                <LogoutButton/>

            </Drawer>
            <div className="sidebar-content">
                <IconButton
                    edge="start"
                    color="inherit"
                    aria-label="menu"
                    onClick={toggleDrawer}
                >
                    <MenuIcon className="sidebar-menu-icon"/>
                </IconButton>
            </div>
        </div>
    );
};
export default Sidebar;