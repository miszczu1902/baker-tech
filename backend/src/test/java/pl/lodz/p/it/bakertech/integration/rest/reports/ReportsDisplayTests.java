package pl.lodz.p.it.bakertech.integration.rest.reports;

import io.restassured.response.Response;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;

import java.util.List;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;

public class ReportsDisplayTests extends BakerTechIntegrationTestConfig {
    public static List<String> getAllAdminReportsURIs() {
        return List.of("percentage-of-orders", "orders-by-serviceman", "orders");
    }

    public static List<String> getAllServicemanReportsURIs() {
        return List.of("average-time", "orders-in-time", "the-most-repaired-device-category", "percentage-of-orders");
    }

    public static List<String> getAllClientReportsURIs() {
        return List.of("amount-of-warranty-devices", "amount-of-executed-orders", "devices-serviced-for-client", "percentage-of-orders");
    }

    @BeforeAll
    public static void initTests() {
        initDb();
    }

    @ParameterizedTest
    @MethodSource("getAllAdminReportsURIs")
    void success_admin_getAdminReportsTest(String uri) {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .get("/api/reports/admin/%s".formatted(uri));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
    }

    @ParameterizedTest
    @MethodSource("getAllServicemanReportsURIs")
    void success_serviceman_getServicemanReportsTest(String uri) {
        Response response = given()
                .when()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .get("/api/reports/serviceman/%s".formatted(uri));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
    }

    @ParameterizedTest
    @MethodSource("getAllClientReportsURIs")
    void success_client_getClientReportsTest(String uri) {
        Response response = given()
                .when()
                .header(keycloakJwtToken(CYPRIAN_BANINO.username(), CYPRIAN_BANINO.password()))
                .get("/api/reports/client/%s".formatted(uri));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
    }

    @Test
    void success_getDatePeriodsTest() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(CYPRIAN_BANINO.username(), CYPRIAN_BANINO.password()))
                .get("/api/reports/dates");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue(response.jsonPath().getList("dates").contains("2023-1"));
        Assertions.assertTrue(response.jsonPath().getList("dates").contains("2023-12"));
        Assertions.assertTrue(response.jsonPath().getList("dates").contains("2024-1"));
    }
}
