import {SET_AVAILABLE_ROLES, SET_CURRENT_ROLE, SET_CURRENT_USER, SET_LANGUAGE, SET_TOKEN} from "./actions";
import {Roles} from "../../security/Roles";
import {Languages} from "../../types/Languages";

export const setCurrentRole = (currentRole: Roles) => {
    return {
        type: SET_CURRENT_ROLE,
        payload: currentRole,
    };
};

export const setAvailableRoles = (availableRoles: Roles[]) => {
    return {
        type: SET_AVAILABLE_ROLES,
        payload: availableRoles,
    };
};

export const setCurrentUser = (currentUser: string | undefined) => {
    return {
        type: SET_CURRENT_USER,
        payload: currentUser,
    };
};

export const setLanguage = (language: Languages) => {
    return {
        type: SET_LANGUAGE,
        payload: language,
    };
};

export const setToken = (token: string | undefined) => {
    return {
        type: SET_TOKEN,
        payload: token,
    };
};