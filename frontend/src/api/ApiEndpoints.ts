export enum ApiEndpoints {
  CLIENT_REGISTRATION_ENDPOINT = "/auth/register-client",
  ACCOUNT_REGISTRATION_ENDPOINT = "/auth/register-serviceman",
  ACCOUNT_ACTIVATION_ENDPOINT = "/auth/activate-account/:confirmationToken",
  GET_ALL_ACCOUNTS_ENDPOINT = "/accounts",
  RESET_PASSWORD = "/accounts/:id/reset-password",
  CHANGE_ACCOUNT_STATUS_ENDPOINT = "/accounts/:id/change-account-status",
  GRANT_ACCESS_LEVELS_ENDPOINT = "/accounts/:id/grant-access-levels",
  REVOKE_ACCESS_LEVELS_ENDPOINTS = "/accounts/:id/revoke-access-levels",
  GET_ALL_DEVICES = "/devices",
  GET_DEVICES_FOR_ORDER = "/devices/devices-for-order/:id",
  GET_DEVICE = "/devices/:id",
  END_DEVICE_WARRANTY = "/devices/:id/mark-ended-warranty",
  GET_ALL_PARAMS = "/service-parameters",
  GET_PARAM = "/service-parameters/:id",
  GET_ALL_ORDERS = "/orders",
  GET_ALL_ORDERS_SERVICEMAN = "/orders/assigned-to-serviceman",
  GET_ORDER = "/orders/:id",
  GET_NEXT_CONSERVATION = "/orders/:id/next-conservation",
  ASSIGN_SERVICEMAN_TO_ORDER = "/orders/:id/assign-serviceman",
  ORDERS_QUEUE = "/orders/orders-queue",
  REPORT_DATES = "/reports/dates",
  ADMIN_REPORT_PERCENTAGE = "/reports/admin/percentage-of-orders",
  ADMIN_ORDERS_IN_PERIOD = "/reports/admin/orders",
  ADMIN_SERVICEMAN_REPORT = "/reports/admin/orders-by-serviceman",
  SERVICEMAN_AVERAGE_TIME = "/reports/serviceman/average-time",
  SERVICEMAN_IN_TIME = "/reports/serviceman/orders-in-time",
  SERVICEMAN_MOST_TYPE = "/reports/serviceman/the-most-repaired-device-category",
  SERVICEMAN_REPORT_PERCENTAGE = "/reports/serviceman/percentage-of-orders",
  CLIENT_DEVICES = "/reports/client/devices-serviced-for-client",
  CLIENT_WARRANTY_DEVICES = "/reports/client/amount-of-warranty-devices",
  CLIENT_EXECUTED_ORDERS = "/reports/client/amount-of-executed-orders",
  CLIENT_REPORT_PERCENTAGE = "/reports/client/percentage-of-orders",
}
