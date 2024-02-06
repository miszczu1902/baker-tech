import Keycloak, { KeycloakTokenParsed } from "keycloak-js";
import { Roles } from "../security/Roles";
import _ from "lodash";
import jwtDecode from "jwt-decode";
import store from "../redux/store";
import {
  setAvailableRoles,
  setCurrentRole,
  setCurrentUser,
  setLogout,
  setToken,
} from "../redux/actions/authActions";
import {
  AuthClientError,
  AuthClientEvent,
} from "@react-keycloak/core/lib/types";
import { APP_URL } from "../utils/consts";

export const login = (keycloak: Keycloak) => {
  keycloak.login().catch(() => {
    window.location.href = "/unauthorized";
  });
};

export const logout = async (keycloak: Keycloak) => {
  keycloak.logout({ redirectUri: APP_URL }).then(() => {});
  logoutAction();
};

export const setKeycloakCurrentUser = (token: any) => {
  if (token !== undefined) {
    let currentRole = store.getState().currentUser.currentRole;
    const roles = store.getState().currentUser.availableRoles;
    const decodedToken = jwtDecode(token.token) as KeycloakTokenParsed;
    const availableRoles = _.intersection(
      decodedToken.realm_access?.roles as string[],
      Object.values(Roles),
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
    }
    setUserDataOnNewToken(
      currentRole,
      token,
      decodedToken,
      availableRoles as Roles[],
    );
  } else {
    logoutAction();
  }
};

export const setUserDataOnNewToken = (
  role: Roles,
  token: any,
  decodedToken: KeycloakTokenParsed | undefined,
  availableRoles: Roles[],
) => {
  const currentRole = store.getState().currentUser.currentRole;
  store.dispatch(setCurrentRole(role !== currentRole ? role : currentRole));
  store.dispatch(setCurrentUser(decodedToken?.preferred_username));
  store.dispatch(setToken(token === undefined ? null : token.token));
  store.dispatch(setAvailableRoles(availableRoles as Roles[]));
};

export const catchEvent = (
  eventType: AuthClientEvent,
  error?: AuthClientError,
) => {
  switch (eventType) {
    case "onAuthLogout":
      logoutAction();
      break;
  }
};

const logoutAction = () => {
  localStorage.clear();
  store.dispatch(setLogout("logout"));
  setUserDataOnNewToken(Roles.GUEST, undefined, undefined, [Roles.GUEST]);
};
