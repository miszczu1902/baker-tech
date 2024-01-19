package pl.lodz.p.it.bakertech.common;

import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import pl.lodz.p.it.bakertech.exceptions.TransactionTimeoutException;
import pl.lodz.p.it.bakertech.interceptors.Interception;
import pl.lodz.p.it.bakertech.interceptors.keycloak.KeycloakInterception;
import pl.lodz.p.it.bakertech.utils.mappers.accounts.KeycloakMapper;
import pl.lodz.p.it.bakertech.exceptions.AppException;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

@Slf4j
@Interception
@KeycloakInterception
@Retryable(
        retryFor = TransactionTimeoutException.class,
        maxAttemptsExpression = "${bakertech.transaction.retry}",
        backoff = @Backoff(delayExpression = "${bakertech.transaction.retry.delay}")
)
public abstract class CommonService {
    protected final RealmResource realmResource;
    protected final KeycloakMapper keycloakMapper;
    protected final ETagGenerator eTagGenerator;

    protected CommonService(@Value("${bakertech.keycloak.realm}") String realmName,
                            Keycloak keycloak,
                            KeycloakMapper keycloakMapper,
                            ETagGenerator eTagGenerator) {
        this.keycloakMapper = keycloakMapper;
        this.realmResource = keycloak.realm(realmName);
        this.eTagGenerator = eTagGenerator;
    }

    protected UserRepresentation getKeycloakUserByUsername(String username) {
        return realmResource.users()
                .search(username)
                .stream()
                .findFirst()
                .orElseThrow(AppException::createKeycloakException);
    }

    protected UserResource getKeycloakUserByUserId(final String userId) {
        return realmResource.users().get(userId);
    }
}
