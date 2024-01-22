package pl.lodz.p.it.bakertech.integration.rest.accounts;

import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;
import pl.lodz.p.it.bakertech.integration.util.TestAccount;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.validation.Messages;

import java.util.List;
import java.util.Set;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;

public class AccountModificationDataTests extends BakerTechIntegrationTestConfig {
    public static List<TestAccount> allServicemen() {
        return List.of(CARL_JOHNSON, MARCIN_KRASUCKI);
    }

    @BeforeEach
    public void initTest() {
        initDb();
    }

    @ParameterizedTest
    @MethodSource("allServicemen")
    void success_grantAndRevokeAccessLevel(TestAccount account) {
        String eTagUrl = "/api/accounts/%s".formatted(account.id());
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(eTagUrl, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR)))
                .post("/api/accounts/%s/grant-access-levels".formatted(account.id()));
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(eTagUrl, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR)))
                .contentType(ContentType.JSON)
                .post("/api/accounts/%s/revoke-access-levels".formatted(account.id()));
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @Test
    void success_changeAccountStatus() {
        String url = "/api/accounts/%s/change-account-status".formatted(MARCIN_KRASUCKI.id());
        String eTagUrl = "/api/accounts/%s".formatted(MARCIN_KRASUCKI.id());
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(eTagUrl, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = auth(MARCIN_KRASUCKI.username(), MARCIN_KRASUCKI.password());
        Assertions.assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode());

        response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(eTagUrl, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @Test
    void error_cannotChangeStatusForOwnAccount() {
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/accounts/%s".formatted(BAKERTECH_ADMIN.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .when()
                .post("/api/accounts/%s/change-account-status".formatted(BAKERTECH_ADMIN.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotChangeStatusSelf, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotAssignAccessLevelSelf() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/accounts/%s".formatted(BAKERTECH_ADMIN.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.SERVICEMAN)))
                .post("/api/accounts/%s/grant-access-levels".formatted(BAKERTECH_ADMIN.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotChangeAccessLevelsSelf, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotRevokeOnlyOneAccessLevel() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/accounts/%s".formatted(MARCIN_KRASUCKI.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.SERVICEMAN)))
                .post("/api/accounts/%s/revoke-access-levels".formatted(MARCIN_KRASUCKI.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotRemoveOneAccessLevel, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotAssignAccessLevelToClient() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/accounts/%s".formatted(CYPRIAN_BANINO.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR, Roles.SERVICEMAN)))
                .post("/api/accounts/%s/grant-access-levels".formatted(CYPRIAN_BANINO.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotAssignAccessLevels, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotVerifyETagTest() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/accounts/%s".formatted(DAWID_JASPER.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR)))
                .post("/api/accounts/%s/grant-access-levels".formatted(CARL_JOHNSON.id()));
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.contentChanged, response.jsonPath().get("message"));

        response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/accounts/%s".formatted(CYPRIAN_BANINO.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR)))
                .post("/api/accounts/%s/change-account-status".formatted(CARL_JOHNSON.id()));
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.contentChanged, response.jsonPath().get("message"));
    }
}
