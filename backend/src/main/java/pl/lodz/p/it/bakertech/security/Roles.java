package pl.lodz.p.it.bakertech.security;

import org.springframework.stereotype.Component;

import java.util.List;

@Component("Roles")
public class Roles {
    public static final String ADMINISTRATOR = "ADMINISTRATOR";
    public static final String SERVICEMAN = "SERVICEMAN";
    public static final String MANAGER = "MANAGER";
    public static final String CLIENT = "CLIENT";

    public static List<String> getAuthenticatedRoles() {
        return List.of(ADMINISTRATOR, SERVICEMAN, MANAGER, CLIENT);
    }
}
