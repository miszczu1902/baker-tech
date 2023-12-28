import {createBrowserRouter, Outlet} from "react-router-dom";
import {Roles} from "./Roles";
import MainPage from "../components/landingPage/MainPage";
import DefaultMenu from "../components/naviagtion/DefaultMenu";
import React from "react";
import PrivateRoute from "./PrivateRoute";
import Unauthorized from "../components/pages/Unauthorized";
import Forbidden from "../components/pages/Forbidden";
import AccountsList from "../components/accounts/AccountsList";
import AccountRegistration from "../components/registration/AccountRegistration";
import RegistrationPassed from "../components/registration/RegistrationPassed";
import AccountPage from "../components/accounts/AccountPage";
import NotFound from "../components/pages/NotFound";

const router = createBrowserRouter([
    {
        path: "/",
        element: (<><DefaultMenu/><Outlet/></>),
        children: [
            {
                path: "/",
                element: <PrivateRoute component={MainPage}
                                       accessLevels={[Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT, Roles.GUEST]}/>
            },
            {
                path: "/accounts",
                element: <PrivateRoute component={AccountsList} accessLevels={[Roles.ADMINISTRATOR]}/>
            },
            {
                path: "/self",
                element: <PrivateRoute component={AccountPage} accessLevels={[Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT]}/>
            },
            {
                path: '/accounts/:id',
                element: <PrivateRoute component={AccountPage} accessLevels={[Roles.SERVICEMAN, Roles.ADMINISTRATOR]}/>
            },
            {
                path: '/accounts/register',
                element: <PrivateRoute component={AccountRegistration} accessLevels={[Roles.ADMINISTRATOR]}/>
            }
        ]
    },
    {
        path: "*",
        element: <PrivateRoute component={NotFound}
                               accessLevels={[Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT, Roles.GUEST]}/>,
    },
    {
        path: "/unauthorized",
        element: <PrivateRoute component={Unauthorized}
                               accessLevels={[Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT, Roles.GUEST]}/>,
    },
    {
        path: "/forbidden",
        element: <PrivateRoute component={Forbidden}
                               accessLevels={[Roles.ADMINISTRATOR, Roles.SERVICEMAN, Roles.CLIENT, Roles.GUEST]}/>,
    },
    {
        path: "/register",
        element: <PrivateRoute component={AccountRegistration} accessLevels={[Roles.GUEST]}/>,
    },
    {
        path: "/registration-passed",
        element: <PrivateRoute component={RegistrationPassed} accessLevels={[Roles.GUEST]}/>,
    },
    {
        path: "/registration-passed/:confirmationToken",
        element: <PrivateRoute component={RegistrationPassed} accessLevels={[Roles.GUEST]}/>,
    }
]);
export default router;