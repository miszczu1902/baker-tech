package pl.lodz.p.it.bakertech.security;

import org.springframework.stereotype.Component;

@Component("Groups")
public class Groups {
    public static final String ADMINISTRATORS = "Administrators";
    public static final String SERVICEMEN = "Servicemen";
    public static final String CLIENTS = "Clients";
}
