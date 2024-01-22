package pl.lodz.p.it.bakertech.utils.mappers.accounts;

import org.keycloak.representations.idm.UserRepresentation;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.AccessLevel;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Administrator;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.Serviceman;
import pl.lodz.p.it.bakertech.model.accounts.accessLevels.client.Client;
import pl.lodz.p.it.bakertech.security.Groups;

import java.util.List;

@Mapper(componentModel = "spring")
public interface KeycloakMapper {
    @Mappings({
            @Mapping(target = "id", ignore = true),
            @Mapping(target = "enabled", expression = "java(setEnable())"),
            @Mapping(target = "credentials", expression = "java(keycloakCredentialRepresentationForUserRepresentation(accessLevel, password))"),
            @Mapping(target = "groups", expression = "java(keycloakGroupsRepresentation(accessLevel))"),
            @Mapping(target = "email", expression = "java(setEmail(accessLevel))"),
            @Mapping(target = "username", expression = "java(setUsername(accessLevel))")
    })
    UserRepresentation accessLevelEntityToKeycloakUserRepresentation(AccessLevel accessLevel, String password);

    default String setEmail(final AccessLevel accessLevel) {
        return accessLevel.getAccount().getEmail();
    }

    default String setUsername(final AccessLevel accessLevel) {
        return accessLevel.getAccount().getUsername();
    }

    default List<String> keycloakGroupsRepresentation(AccessLevel accessLevel) {
        switch (accessLevel) {
            case Administrator ignored -> {
                return List.of(Groups.ADMINISTRATORS);
            }
            case Serviceman ignored -> {
                return List.of(Groups.SERVICEMEN);
            }
            default -> {
                return List.of(Groups.CLIENTS);
            }
        }
    }

    default CredentialRepresentation keycloakCredentialRepresentation(AccessLevel accessLevel, String password) {
        CredentialRepresentation secret = new CredentialRepresentation();
        secret.setTemporary(!(accessLevel instanceof Client));
        secret.setType(CredentialRepresentation.PASSWORD);
        secret.setValue(password);
        return secret;
    }

    default List<CredentialRepresentation> keycloakCredentialRepresentationForUserRepresentation(AccessLevel accessLevel, String password) {
        return List.of(keycloakCredentialRepresentation(accessLevel, password));
    }

    default boolean setEnable() {
        return false;
    }
}
