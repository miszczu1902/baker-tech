import React from "react";
import ReactDOM from "react-dom/client";
import reportWebVitals from "./reportWebVitals";
import router from "./security/SecurityRouter";
import {RouterProvider} from "react-router-dom";
import './styles/index.scss';
import {Provider} from "react-redux";
import store from "./redux/store";

const root = ReactDOM.createRoot(
    document.getElementById("root") as HTMLElement
);

root.render(
    <React.StrictMode>
        <Provider store={store}>
            <RouterProvider router={router}/>
        </Provider>
    </React.StrictMode>
);
reportWebVitals();
