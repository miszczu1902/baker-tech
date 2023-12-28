package pl.lodz.p.it.bakertech.security;

import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component("Roles")
public class Roles {
    public static final String ADMINISTRATOR = "ADMINISTRATOR";
    public static final String SERVICEMAN = "SERVICEMAN";
    public static final String CLIENT = "CLIENT";
    public static final String GUEST = "GUEST";
    public static final String SYSTEM = "SYSTEM";

    public static List<String> getAuthenticatedRoles() {
        return List.of(ADMINISTRATOR, SERVICEMAN, CLIENT);
    }

    public static String[] getAllRoles() {
        return new String[]{ADMINISTRATOR, SERVICEMAN, CLIENT, GUEST};
    }

    public static Map<String, String> getAuthenticatedRolesWithGroups() {
        return Map.of(ADMINISTRATOR, Groups.ADMINISTRATORS, SERVICEMAN, Groups.SERVICEMEN, CLIENT, Groups.CLIENTS);
    }
}
