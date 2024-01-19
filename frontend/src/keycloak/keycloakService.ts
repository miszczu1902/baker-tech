import Keycloak, { KeycloakTokenParsed } from "keycloak-js";
import { Roles } from "../security/Roles";
import _ from "lodash";
import jwtDecode from "jwt-decode";
import store from "../redux/store";
import {
  setAvailableRoles,
  setCurrentRole,
  setCurrentUser,
  setToken
} from "../redux/actions/authActions";
import {
  AuthClientError,
  AuthClientEvent
} from "@react-keycloak/core/lib/types";
import keycloak from "./keycloak";

export const login = (keycloak: Keycloak) => {
  keycloak.login().catch(() => {
    window.location.href = "/unauthorized";
  });
};

export const logout = (keycloak: Keycloak) => {
  keycloak.logout().catch(() => {
  });
  window.location.href = "/";
  store.dispatch(setCurrentRole(Roles.GUEST));
  store.dispatch(setAvailableRoles([Roles.GUEST]));
  store.dispatch(setCurrentUser(""));
};

export const setKeycloakCurrentUser = (token: any) => {
  if (token !== undefined) {
    let currentRole = store.getState().currentUser.currentRole;
    const roles = store.getState().currentUser.availableRoles;
    const decodedToken = jwtDecode(token) as KeycloakTokenParsed;
    const availableRoles = _.intersection(
      decodedToken.realm_access?.roles as string[],
      Object.values(Roles)
    );

    if (
      !currentRole ||
      currentRole === Roles.GUEST ||
      _.size(roles) !== _.size(availableRoles)
    ) {
      if (currentRole === Roles.GUEST) {
        for (const availableRole of availableRoles) {
          switch (availableRole) {
            case Roles.ADMINISTRATOR.valueOf():
              currentRole = Roles.ADMINISTRATOR;
              break;
            case Roles.SERVICEMAN.valueOf():
              currentRole = Roles.SERVICEMAN;
              break;
            case Roles.CLIENT.valueOf():
              currentRole = Roles.CLIENT;
              break;
          }
        }
      }
      store.dispatch(setAvailableRoles(availableRoles as Roles[]));
    }
    setUserDataOnNewToken(currentRole, token, decodedToken);
  }
};

export const setUserDataOnNewToken = (
  role: Roles,
  token: any,
  decodedToken: KeycloakTokenParsed
) => {
  const currentRole = store.getState().currentUser.currentRole;
  store.dispatch(setCurrentRole(role !== currentRole ? role : currentRole));
  store.dispatch(setCurrentUser(decodedToken.preferred_username));
  store.dispatch(setToken(token));
};

export const catchEvent = (
  eventType: AuthClientEvent,
  error?: AuthClientError
) => {
  switch (eventType) {
    case "onAuthRefreshSuccess":
    case "onAuthSuccess":
      setKeycloakCurrentUser(keycloak.token);
      break;
  }
};
