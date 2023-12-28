import React, {useEffect, useState} from "react";
import {useSelector} from "react-redux";
import {RootState} from "../redux/store";
import {useKeycloak} from "@react-keycloak/web";
import {useNavigate} from "react-router-dom";

interface PrivateRouteProps {
    component: React.ComponentType<any>;
    accessLevels: string[];
}

const PrivateRoute: React.FC<PrivateRouteProps> = ({component: Component, accessLevels, ...rest}) => {
    const currentRole = useSelector((state: RootState) => state.currentUser).currentRole as string;
    const navigate = useNavigate();
    const {keycloak} = useKeycloak();
    const [isReadyToRender, setIsReadyToRender] = useState<boolean>(false);

    useEffect(() => {
        console.log(keycloak);
        accessLevels.includes(currentRole) ? setIsReadyToRender(true) : navigate('/forbidden');
    }, [window.location.pathname, currentRole]);

    return isReadyToRender ? <Component {...rest} /> : null;
};
export default PrivateRoute;