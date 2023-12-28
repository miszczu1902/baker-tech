import React from "react";
import ReactDOM from "react-dom/client";
import reportWebVitals from "./reportWebVitals";
import router from "./security/SecurityRouter";
import {RouterProvider} from "react-router-dom";
import './styles/index.scss';
import {Provider} from "react-redux";
import store from "./redux/store";
import keycloak from "./keycloak/keycloak";
import {ReactKeycloakProvider} from '@react-keycloak/web';
import {setKeycloakCurrentUser, eventHandler} from "./keycloak/keycloakService";

const root = ReactDOM.createRoot(
    document.getElementById("root") as HTMLElement
);

root.render(
    <ReactKeycloakProvider
        authClient={keycloak}
        autoRefreshToken={true}
        onTokens={setKeycloakCurrentUser}
        onEvent={eventHandler}
    >
        <Provider store={store}>
            <RouterProvider router={router}/>
        </Provider>
    </ReactKeycloakProvider>
);
reportWebVitals();
