package pl.lodz.p.it.bakertech.integration.accounts;

import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.accounts.dto.accounts.account.AccessLevelsDTO;
import pl.lodz.p.it.bakertech.integration.config.BakerTechTestConfig;
import pl.lodz.p.it.bakertech.integration.util.TestAccount;
import pl.lodz.p.it.bakertech.security.Roles;
import pl.lodz.p.it.bakertech.validation.Messages;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;

public class AccountModuleTests extends BakerTechTestConfig {
    @ParameterizedTest
    @ValueSource(strings = {"", "username", "email", "isActive"})
    void success_getAllAccountsTest(String queryParam) {
        Object queryParamValue;
        switch (queryParam) {
            case "username" -> queryParamValue = BAKERTECH_ADMIN.username();
            case "email" -> queryParamValue = BAKERTECH_ADMIN.email();
            case "isActive" -> queryParamValue = true;
            default -> queryParamValue = null;
        }

        RequestSpecification header = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()));
        if (Optional.ofNullable(queryParamValue).isPresent()) {
            header.queryParam(queryParam, queryParamValue);
        }
        Response response = header.get("/api/accounts");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue((int) (response.jsonPath().get("totalElements")) > 0);
    }

    @ParameterizedTest
    @MethodSource("allAccounts")
    void success_getSelfAccountDataTest(TestAccount account) {
        Response response = given()
                .header(keycloakJwtToken(account.username(), account.password()))
                .when()
                .get("/api/accounts/self");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertEquals(account.username(), response.jsonPath().get("username"));
        Assertions.assertEquals(account.email(), response.jsonPath().get("email"));
    }

    @ParameterizedTest
    @MethodSource("allServicemen")
    void success_grantAndRevokeAccessLevel(TestAccount account) {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR)))
                .post("/api/accounts/%s/grant-access-levels".formatted(account.id()));
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR)))
                .contentType(ContentType.JSON)
                .post("/api/accounts/%s/revoke-access-levels".formatted(account.id()));
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @Test
    void success_changeAccountStatus() {
        String url = "/api/accounts/%s/change-account-status".formatted(MARCIN_KRASUCKI.id());

        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = auth(MARCIN_KRASUCKI.username(), MARCIN_KRASUCKI.password());
        Assertions.assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode());

        response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @Test
    void error_cannotChangeStatusForOwnAccount() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .post("/api/accounts/%s/change-account-status".formatted(BAKERTECH_ADMIN.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotChangeStatusSelf, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotAssignAccessLevelSelf() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.SERVICEMAN)))
                .post("/api/accounts/%s/grant-access-levels" .formatted(BAKERTECH_ADMIN.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotChangeAccessLevelsSelf, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotRevokeOnlyOneAccessLevel() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.SERVICEMAN)))
                .post("/api/accounts/%s/revoke-access-levels" .formatted(MARCIN_KRASUCKI.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotRemoveOneAccessLevel, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotAssignAccessLevelToClient() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .contentType(ContentType.JSON)
                .body(new AccessLevelsDTO(Set.of(Roles.ADMINISTRATOR, Roles.SERVICEMAN)))
                .post("/api/accounts/%s/grant-access-levels" .formatted(CYPRIAN_BANINO.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotAssignAccessLevels, response.jsonPath().get("message"));
    }

    public static List<TestAccount> allAccounts() {
        return List.of(BAKERTECH_ADMIN, CARL_JOHNSON, CYPRIAN_BANINO, MARCIN_KRASUCKI);
    }

    public static List<TestAccount> allServicemen() {
        return List.of(CARL_JOHNSON, MARCIN_KRASUCKI);
    }
}
