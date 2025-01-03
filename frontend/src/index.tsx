import React from "react";
import ReactDOM from "react-dom/client";
import reportWebVitals from "./reportWebVitals";
import router from "./security/SecurityRouter";
import { RouterProvider } from "react-router-dom";
import "./styles/index.scss";
import { Provider } from "react-redux";
import store from "./redux/store";
import keycloak from "./keycloak/keycloak";
import { ReactKeycloakProvider } from "@react-keycloak/web";
import {catchEvent, setKeycloakCurrentUser} from "./keycloak/keycloakService";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement,
);

root.render(
  <ReactKeycloakProvider
    authClient={keycloak}
    autoRefreshToken={true}
    onEvent={catchEvent}
    onTokens={setKeycloakCurrentUser}
  >
    <Provider store={store}>
      <RouterProvider router={router} />
    </Provider>
  </ReactKeycloakProvider>,
);

reportWebVitals();
