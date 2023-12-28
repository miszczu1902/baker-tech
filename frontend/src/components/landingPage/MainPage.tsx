import {Roles} from "../../security/Roles";
import AdminDashboard from "../reports/AdminDashboard";
import ServicemanDashboard from "../reports/ServicemanDashboard";
import ClientDashboard from "../reports/ClientDashboard";
import LandingPage from "./LandingPage";
import {useSelector} from "react-redux";
import {RootState} from "../../redux/store";

const MainPage = () => {
    const currentRole = useSelector((state: RootState) => state.currentUser).currentRole;

    return (
        currentRole !== Roles.GUEST ?
            <div>
                {currentRole === Roles.ADMINISTRATOR && <AdminDashboard/>}
                {currentRole === Roles.SERVICEMAN && <ServicemanDashboard/>}
                {currentRole === Roles.CLIENT && <ClientDashboard/>}
            </div>
            : <LandingPage/>
    );
}
export default MainPage;