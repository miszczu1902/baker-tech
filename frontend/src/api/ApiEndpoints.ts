export enum ApiEndpoints {
    CLIENT_REGISTRATION_ENDPOINT = '/auth/register-client',
    ACCOUNT_REGISTRATION_ENDPOINT = '/auth/register-serviceman',
    ACCOUNT_ACTIVATION_ENDPOINT = '/auth/activate-account/:confirmationToken',
    GET_ALL_ACCOUNTS_ENDPOINT = '/accounts',
    CHANGE_ACCOUNT_STATUS_ENDPOINT = '/accounts/:id/change-account-status',
    GRANT_ACCESS_LEVELS_ENDPOINT = '/accounts/:id/grant-access-levels',
    REVOKE_ACCESS_LEVELS_ENDPOINTS = '/accounts/:id/revoke-access-levels',
}