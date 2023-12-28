import {KeycloakTokenParsed} from "keycloak-js";
import {Roles} from "../security/Roles";
import _ from "lodash";
import jwtDecode from "jwt-decode";
import store from "../redux/store";
import {setAvailableRoles, setCurrentRole, setCurrentUser, setToken} from "../redux/actions/authAction";
import {AuthClientError, AuthClientEvent} from "@react-keycloak/core/lib/types";

export const setKeycloakCurrentUser = (tokens: any) => {
    console.log(tokens);
    if (tokens !== undefined) {
        let currentRole = store.getState().currentUser.currentRole;
        const roles = store.getState().currentUser.availableRoles;
        const decodedToken = jwtDecode(tokens.token) as KeycloakTokenParsed;
        const availableRoles = _.intersection(decodedToken.realm_access?.roles as string[], Object.values(Roles));

        if (!currentRole || currentRole === Roles.GUEST || _.size(roles) !== _.size(availableRoles)) {
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
                store.dispatch(setCurrentRole(currentRole));
                store.dispatch(setCurrentUser(decodedToken.preferred_username));
                store.dispatch(setToken(tokens.token));
            }
            store.dispatch(setAvailableRoles(availableRoles as Roles[]));
        }
    }
}

export const redirectAfter = () => {
    let pathname = window.location.pathname;
    window.location.href = pathname !== '/' ? pathname : '/';
}

export const eventHandler = (eventType: AuthClientEvent, error?: AuthClientError) => {
    if (eventType === 'onTokenExpired' || eventType === 'onAuthRefreshError') {
        window.location.reload();
    }
}