import React, { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { RootState } from "../redux/store";
import { useNavigate } from "react-router-dom";
import NotificationHandler from "../components/response/NotificationHandler";
import keycloak from "../keycloak/keycloak";

interface PrivateRouteProps {
  component: React.ComponentType<any>;
  accessLevels: string[];
}

const PrivateRoute: React.FC<PrivateRouteProps> = ({
  component: Component,
  accessLevels,
  ...rest
}) => {
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as string;
  const notificationDisplay = useSelector(
    (state: RootState) => state.notificationDisplay,
  );
  const navigate = useNavigate();
  const [isReadyToRender, setIsReadyToRender] = useState<boolean>(false);

  useEffect(() => {
    accessLevels.includes(currentRole)
      ? setIsReadyToRender(true)
      : navigate("/forbidden");
  }, [
    window.location.pathname,
    currentRole,
    notificationDisplay,
    keycloak.token
  ]);

  return (
    <div>
      {isReadyToRender ? <Component {...rest} /> : null}
      <NotificationHandler
        isOpenConfirm={notificationDisplay.isOpen}
        onChangeConfirm={() => {}}
        isOpenAlert={notificationDisplay.isOpenAlert}
        onChangeAlert={() => {}}
      />
    </div>
  );
};
export default PrivateRoute;
