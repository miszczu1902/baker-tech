import {RequestData} from "./RequestData";
import axios, {AxiosError, AxiosRequestConfig, InternalAxiosRequestConfig, AxiosResponse} from "axios";
import {ErrorResponseData} from "./ErrorResponseData";
import {API_URL, DEFAULT_TIMEOUT} from "../utils/consts";

class RequestService {
    private axiosInstance = axios.create({
        baseURL: API_URL,
        timeout: DEFAULT_TIMEOUT,
    });

    constructor() {
        this.axiosInstance.interceptors.request.use(this.requestInterceptor);
        this.axiosInstance.interceptors.response.use(this.responseSuccessInterceptor, this.responseErrorInterceptor);
    }

    private requestInterceptor = (config: InternalAxiosRequestConfig): InternalAxiosRequestConfig => {
        // if (config.headers) {
        //     config.headers['Authorization'] = `Bearer JWT_TOKEN`;
        // }
        return config;
    };

    private responseSuccessInterceptor = (response: AxiosResponse) => {
        return response;
    };

    private responseErrorInterceptor = (error: AxiosError) => {
        if (error.response) {
            const errorResponseData = error.response.data as ErrorResponseData;
            return Promise.reject(errorResponseData);
        } else if (error.request) {
            return Promise.reject(error);
        } else {
            return Promise.reject(error);
        }
    };

    public async sendRequestAndGetResponse<T>(requestData: RequestData): Promise<T> {
        const config: AxiosRequestConfig = {
            method: requestData.method.toString(),
            url: requestData.endpoint,
            data: requestData.data,
            headers: requestData.headers
        };
        return this.axiosInstance.request<T>(config)
            .then((response) => response.data);
    }
}

export {RequestService};