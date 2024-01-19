export const APP_URL = process.env.REACT_APP_URL as string;
export const API_URL = process.env.REACT_APP_API_URL as string;
export const REFRESH_TOKEN_TIME = Number(
  process.env.REACT_APP_REFRESH_TOKEN_TIME,
);
export const DEFAULT_TIMEOUT = Number(process.env.REACT_APP_DEFAULT_TIMEOUT);
export const ALERT_AUTOHIDE = Number(process.env.REACT_APP_ALERT_AUTOHIDE);
export const DEFAULT_PAGE_SIZE = Number(
  process.env.REACT_APP_DEFAULT_PAGE_SIZE,
);
export const ORDERS_QUEUE_PAGE_SIZE = Number(
  process.env.REACT_APP_ORDERS_QUEUE_PAGE_SIZE,
);
export const REALM_NAME = process.env.REACT_APP_REALM_NAME as string;
export const CLIENT_ID = process.env.REACT_APP_CLIENT_ID as string;
export const KEYCLOAK_URL = process.env.REACT_APP_KEYCLOAK_URL as string;
