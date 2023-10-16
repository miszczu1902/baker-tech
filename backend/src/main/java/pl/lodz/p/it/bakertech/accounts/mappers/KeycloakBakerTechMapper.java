package pl.lodz.p.it.bakertech.accounts.mappers;

import org.keycloak.representations.idm.UserRepresentation;
import org.keycloak.representations.idm.CredentialRepresentation;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterClientDTO;
import pl.lodz.p.it.bakertech.accounts.dto.RegisterServicemanDTO;
import pl.lodz.p.it.bakertech.security.Groups;

import java.util.List;

public class KeycloakBakerTechMapper {
    public static UserRepresentation toKeycloakUserRepresentation(RegisterClientDTO client) {
        UserRepresentation userRepresentation = new UserRepresentation();

        userRepresentation.setUsername(client.username());
        userRepresentation.setEmail(client.email());
        userRepresentation.setCredentials(List.of(toKeycloakCredentialRepresentation(client.password())));
        userRepresentation.setEnabled(true);
        userRepresentation.setGroups(List.of(Groups.CLIENTS));

        return userRepresentation;
    }

    public static UserRepresentation toKeycloakUserRepresentation(RegisterServicemanDTO serviceman) {
        UserRepresentation userRepresentation = new UserRepresentation();

        userRepresentation.setUsername(serviceman.username());
        userRepresentation.setEmail(serviceman.email());
        userRepresentation.setCredentials(List.of(toKeycloakCredentialRepresentation(serviceman.password())));
        userRepresentation.setEnabled(true);
        userRepresentation.setGroups(List.of(Groups.SERVICEMEN));

        return userRepresentation;
    }

    public static CredentialRepresentation toKeycloakCredentialRepresentation(String password) {
        CredentialRepresentation secret = new CredentialRepresentation();

        secret.setTemporary(false);
        secret.setType(CredentialRepresentation.PASSWORD);
        secret.setValue(password);

        return secret;
    }
}
