import { CLIENT_ID, KEYCLOAK_URL, REALM_NAME } from "../utils/consts";
import Keycloak from "keycloak-js";

const keycloak = new Keycloak({
  url: KEYCLOAK_URL,
  realm: REALM_NAME,
  clientId: CLIENT_ID,
});
export default keycloak;
