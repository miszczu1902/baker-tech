package pl.lodz.p.it.bakertech.integration.rest.service;

import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;
import pl.lodz.p.it.bakertech.validation.Messages;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;
import static pl.lodz.p.it.bakertech.integration.util.TestDevice.*;

public class DevicesModificationDataTests extends BakerTechIntegrationTestConfig {
    @BeforeEach
    public void initTest() {
        initDb();
    }

    @Test
    void success_endDeviceWarranty() {
        String url = "/api/devices/%s/mark-ended-warranty".formatted(SUPERIOR_BAKE.id());
        String eTagUrl = "/api/devices/%s".formatted(SUPERIOR_BAKE.id());
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(eTagUrl, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @Test
    void success_addNewDevice() {
        String url = "/api/devices";
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .body(DEVICE_TO_ADD)
                .contentType(ContentType.JSON)
                .post(url);
        Assertions.assertEquals(HttpStatus.CREATED.value(), response.getStatusCode());
    }

    @Test
    void error_deviceNotUnique() {
        success_addNewDevice();
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(DEVICE_TO_ADD)
                .post("/api/devices");
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
    }

    @Test
    void error_cannotEndWarrantyForDeviceWithoutWarranty() {
        success_endDeviceWarranty();
        String url = "/api/devices/%s/mark-ended-warranty".formatted(SUPERIOR_BAKE.id());
        String eTagUrl = "/api/devices/%s".formatted(SUPERIOR_BAKE.id());
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(eTagUrl, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotChangeWarranty, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotVerifyETagTest() {
        Response response = given()
                .when()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(
                        "/api/devices/%s".formatted(SUPERIOR_BAKE.id()),
                        BAKERTECH_ADMIN.username(),
                        BAKERTECH_ADMIN.password()))
                .post("/api/devices/%s/mark-ended-warranty".formatted(MEGA_BAKERS.id()));
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.contentChanged, response.jsonPath().get("message"));
    }
}
