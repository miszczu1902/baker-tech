import { RequestData } from "./RequestData";
import axios, { AxiosError, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from "axios";
import { ErrorResponseData } from "./ErrorResponseData";
import { ALERT_AUTOHIDE, API_URL, DEFAULT_TIMEOUT } from "../utils/consts";
import store from "../redux/store";
import { Roles } from "../security/Roles";
import { setETag } from "../redux/actions/authActions";
import { delay } from "lodash";

class RequestService {
  private axiosInstance = axios.create({
    baseURL: API_URL,
    timeout: DEFAULT_TIMEOUT,
  });

  private static instance: RequestService;

  constructor() {
    this.axiosInstance.interceptors.request.use(this.requestInterceptor);
    this.axiosInstance.interceptors.response.use(
      this.responseSuccessInterceptor,
      this.responseErrorInterceptor,
    );
    RequestService.instance = this;
  }

  private requestInterceptor = (
    config: InternalAxiosRequestConfig,
  ): InternalAxiosRequestConfig => {
    if (config.headers) {
      const currentUser = store.getState().currentUser;
      config.headers["Accept-Language"] = currentUser.language;
      config.headers["If-Match"] = currentUser.eTag;
      if (currentUser.token && currentUser.currentRole !== Roles.GUEST) {
        config.headers["Authorization"] = `Bearer ${currentUser.token}`;
      }
    }
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

  public static getInstance(): RequestService {
    return !RequestService.instance
      ? new RequestService()
      : RequestService.instance;
  }

  public async sendRequestAndGetResponse<T>(
    requestData: RequestData,
  ): Promise<T> {
    const config: AxiosRequestConfig = {
      method: requestData.method.toString(),
      url: requestData.endpoint,
      data: requestData.data,
      headers: requestData.headers,
      params: requestData.queryParams,
    };
    return this.axiosInstance.request<T>(config).then((response) => {
      store.dispatch(setETag(response.headers["etag"]));
      if (store.getState().currentUser.currentRole !== Roles.GUEST && response.status === 201) {
        delay(() => window.location.href = response.headers["location"], ALERT_AUTOHIDE / 5);
      }
      return response.data;
    });
  }
}

export { RequestService };
