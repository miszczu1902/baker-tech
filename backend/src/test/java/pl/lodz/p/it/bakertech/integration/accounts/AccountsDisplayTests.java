package pl.lodz.p.it.bakertech.integration.accounts;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechTestConfig;
import pl.lodz.p.it.bakertech.integration.util.TestAccount;

import java.util.List;
import java.util.Optional;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;

public class AccountsDisplayTests extends BakerTechTestConfig {
    public static List<TestAccount> allAccounts() {
        return List.of(BAKERTECH_ADMIN, CARL_JOHNSON, CYPRIAN_BANINO, MARCIN_KRASUCKI, DAWID_JASPER);
    }

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
}
