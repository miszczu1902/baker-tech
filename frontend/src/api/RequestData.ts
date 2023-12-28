export enum RequestMethod {
    GET = 'get',
    POST = 'post',
    PUT = 'put',
    PATCH = 'patch',
    DELETE = 'delete'
}

export interface RequestData {
    method: RequestMethod;
    endpoint?: string;
    headers?: Record<string, string>;
    data?: any;
    queryParams?: Record<string, string | number>;
}