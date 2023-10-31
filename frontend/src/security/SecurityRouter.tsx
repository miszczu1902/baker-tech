import { createBrowserRouter } from "react-router-dom";
import LandingPage from "../components/landingPage/LandingPage";
import path from "path";
import Registration from "../components/registration/Registration";

// interface PrivateRouteProps {
//     component: React.ComponentType<any>;
//     accessLevels: string[];
// }

// const PrivateRoute: React.FC<PrivateRouteProps> = ({component: Component, accessLevels, ...rest}) => {
//     const userAccessLevel = localStorage.getItem("role");
//     const navigate = useNavigate();
//     const token = localStorage.getItem("token");

//     useEffect(() => {
//         if (token === null) {
//             localStorage.setItem("role", GUEST);
//         }
//         if (userAccessLevel !== null && !accessLevels.includes(userAccessLevel)) {
//             navigate('/');
//         }
//     }, [localStorage.getItem("role")]);
//     return <Component {...rest} />;
// };

const router = createBrowserRouter([
  {
    path: "/",
    element: <LandingPage />,
  },
  {
    path: "/register",
    element: <Registration />,
  },
]);
export default router;