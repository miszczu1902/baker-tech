import { Roles } from "../../security/Roles";
import {
  LOGOUT,
  SET_AVAILABLE_ROLES,
  SET_CURRENT_ROLE,
  SET_CURRENT_USER,
  SET_ETAG,
  SET_LANGUAGE,
  SET_TOKEN
} from "../actions/actions";
import { Languages } from "../../types/Languages";

const initialState = {
  currentRole: localStorage.getItem("role") || Roles.GUEST,
  availableRoles: localStorage.getItem("availableRoles") || [Roles.GUEST],
  currentUser: localStorage.getItem("currentUser") || undefined,
  language: localStorage.getItem("language") || Languages.pl,
  token: localStorage.getItem("token") || undefined,
  eTag: localStorage.getItem("etag") || undefined
};

const currentRoleReducer = (state = initialState, action: any) => {
  switch (action.type) {
    case SET_CURRENT_ROLE:
      return {
        ...state,
        currentRole: action.payload
      };
    case SET_AVAILABLE_ROLES:
      return {
        ...state,
        availableRoles: action.payload
      };
    case SET_CURRENT_USER:
      return {
        ...state,
        currentUser: action.payload
      };
    case SET_LANGUAGE:
      return {
        ...state,
        language: action.payload
      };
    case SET_TOKEN:
      return {
        ...state,
        token: action.payload
      };
    case SET_ETAG:
      return {
        ...state,
        eTag: action.payload
      };
    case LOGOUT:
      localStorage.clear();
      return {
        ...state,
        eTag: undefined,
        token: undefined,
        language: Languages.pl,
        currentUser: undefined,
        availableRoles: [Roles.GUEST],
        currentRole: Roles.GUEST
      };
    default:
      return state;
  }
};

export default currentRoleReducer;
