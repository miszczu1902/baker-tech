package pl.lodz.p.it.bakertech.integration.rest.service;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;

import java.util.Optional;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.BAKERTECH_ADMIN;
import static pl.lodz.p.it.bakertech.integration.util.TestDevice.MEGA_BAKERS;

public class DevicesDisplayTests extends BakerTechIntegrationTestConfig {
    @ParameterizedTest
    @ValueSource(strings = {"", "serialNumber", "warrantyEnded", "category"})
    void success_getAllDevicesTest(String queryParam) {
        Object queryParamValue;
        switch (queryParam) {
            case "serialNumber" -> queryParamValue = MEGA_BAKERS.serialNumber();
            case "warrantyEnded" -> queryParamValue = MEGA_BAKERS.warrantyEnded();
            case "category" -> queryParamValue = MEGA_BAKERS.category();
            default -> queryParamValue = null;
        }

        RequestSpecification header = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()));
        if (Optional.ofNullable(queryParamValue).isPresent()) {
            header.queryParam(queryParam, queryParamValue);
        }
        Response response = header.get("/api/devices");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue((int) (response.jsonPath().get("totalElements")) > 0);
    }

    @Test
    void success_getDeviceTest() {
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .get("/api/devices/%s".formatted(MEGA_BAKERS.id()));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertEquals(eTagGenerator.generateETagValue(MEGA_BAKERS), response.getHeaders().get("ETag").getValue());
    }
    @Test
    void success_getDevicesForOrder() {
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .get("/api/devices/devices-for-order/%s".formatted(-4));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
    }

    @Test
    void error_objectNotFound() {
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .get("/api/devices/%s".formatted(-1000000L));
        Assertions.assertEquals(HttpStatus.NOT_FOUND.value(), response.getStatusCode());
    }
}
