import { Roles } from "../../security/Roles";
import { useSelector } from "react-redux";
import { RootState } from "../../redux/store";
import LandingPage from "./LandingPage";
import Dashboard from "../reports/Dashboard";

const MainPage = () => {
  const currentRole = useSelector(
    (state: RootState) => state.currentUser,
  ).currentRole;

  return (
    <div>
      {currentRole === Roles.GUEST ?  <LandingPage/> : <Dashboard/>}
    </div>
  );
};
export default MainPage;
