import {Roles} from "../../security/Roles";
import {SET_AVAILABLE_ROLES, SET_CURRENT_ROLE, SET_CURRENT_USER, SET_LANGUAGE, SET_TOKEN} from "../actions/actions";
import {Languages} from "../../types/Languages";

const initialState = {
    currentRole: localStorage.getItem("role") || Roles.GUEST,
    availableRoles: localStorage.getItem("availableRoles") || [Roles.GUEST],
    currentUser: localStorage.getItem("currentUser") || undefined,
    language: localStorage.getItem("language") || navigator.language as Languages,
    token: localStorage.getItem("token") || undefined
};

const currentRoleReducer = (state = initialState, action: any) => {
    switch (action.type) {
        case SET_CURRENT_ROLE:
            localStorage.setItem("role", action.payload);
            return {
                ...state,
                currentRole: action.payload,
            };
        case SET_AVAILABLE_ROLES:
            localStorage.setItem("availableRoles", action.payload);
            return {
                ...state,
                availableRoles: action.payload,
            };
        case SET_CURRENT_USER:
            localStorage.setItem("currentUser", action.payload);
            return {
                ...state,
                currentUser: action.payload,
            };
        case SET_LANGUAGE:
            localStorage.setItem("language", action.payload);
            return {
                ...state,
                language: action.payload,
            };
        case SET_TOKEN:
            localStorage.setItem("token", action.payload);
            return {
                ...state,
                token: action.payload,
            };
        default:
            return state;
    }
};

export default currentRoleReducer;