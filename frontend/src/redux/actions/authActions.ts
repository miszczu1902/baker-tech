import {
  LOGOUT,
  SET_AVAILABLE_ROLES,
  SET_CURRENT_ROLE,
  SET_CURRENT_USER,
  SET_ETAG,
  SET_LANGUAGE,
  SET_TOKEN
} from "./actions";
import { Roles } from "../../security/Roles";
import { Languages } from "../../types/Languages";

export const setCurrentRole = (currentRole: Roles) => {
  localStorage.setItem("role", currentRole);
  return {
    type: SET_CURRENT_ROLE,
    payload: currentRole,
  };
};

export const setAvailableRoles = (availableRoles: Roles[]) => {
  localStorage.setItem("availableRoles", availableRoles.toString());
  return {
    type: SET_AVAILABLE_ROLES,
    payload: availableRoles,
  };
};

export const setCurrentUser = (currentUser: string | undefined) => {
  if (typeof currentUser === "string") {
    localStorage.setItem("currentUser", currentUser);
  }
  return {
    type: SET_CURRENT_USER,
    payload: currentUser,
  };
};

export const setLanguage = (language: Languages) => {
  localStorage.setItem("language", language);
  return {
    type: SET_LANGUAGE,
    payload: language,
  };
};

export const setToken = (token: string | undefined) => {
  if (typeof token === "string") {
    localStorage.setItem("token", token);
  } else {
    localStorage.removeItem("token");
  }
  return {
    type: SET_TOKEN,
    payload: token,
  };
};

export const setETag = (etag: string | undefined) => {
  if (typeof etag === "string") {
    localStorage.setItem("etag", etag);
  }
  return {
    type: SET_ETAG,
    payload: etag,
  };
};

export const setLogout = (data: any) => {
  localStorage.clear();
  return {
    type: LOGOUT,
    payload: data,
  };
};
