import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../../redux/store";
import { Roles } from "../../../security/Roles";
import Chip from "@mui/material/Chip";
import React, { useEffect } from "react";
import { useTranslation } from "react-i18next";
import { setCurrentRole } from "../../../redux/actions/authActions";

const AccessLevelSwitch = () => {
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as string;
  let availableRoles = useSelector(
    (state: RootState) => state.currentUser,
  ).availableRoles;
  const dispatch = useDispatch();
  const { t } = useTranslation();

  useEffect(() => {
    availableRoles = Array.isArray(availableRoles)
      ? (availableRoles as Roles[])
      : (availableRoles.split(",") as Roles[]);
  }, [currentRole, availableRoles, window.location.pathname]);

  return (
    <div className="access-level-switches">
      {Array.isArray(availableRoles) &&
        availableRoles.map((lvl) => {
          return (
            <Chip
              key={lvl}
              className={
                (lvl as Roles | string) === currentRole
                  ? "data-chip-active"
                  : "data-chip-neutral"
              }
              label={t(`accounts.levels.${lvl.toLowerCase()}`)}
              onClick={() => dispatch(setCurrentRole(lvl))}
            />
          );
        })}
    </div>
  );
};
export default AccessLevelSwitch;
