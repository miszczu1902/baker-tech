import AccountDataPage from "./AccountDataPage";
import { RequestData, RequestMethod } from "../../api/RequestData";
import { ApiEndpoints } from "../../api/ApiEndpoints";
import { useParams } from "react-router-dom";
import { useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import { Roles } from "../../security/Roles";
import { useEffect } from "react";

const AccountPage = () => {
  const { id } = useParams();
  const currentRole = useSelector((state: RootState) => state.currentUser)
    .currentRole as string;

  const accountDataRequest: RequestData = {
    method: RequestMethod.GET,
    endpoint: `${ApiEndpoints.GET_ALL_ACCOUNTS_ENDPOINT}/${id ? id : "self"}`,
  };

  useEffect(() => {}, [currentRole, id, window.location.pathname]);

  return (
    <AccountDataPage
      request={accountDataRequest}
      toModifications={(currentRole === Roles.ADMINISTRATOR && id) as boolean}
    />
  );
};
export default AccountPage;
