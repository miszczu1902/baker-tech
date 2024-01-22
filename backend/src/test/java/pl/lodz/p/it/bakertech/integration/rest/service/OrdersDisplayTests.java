package pl.lodz.p.it.bakertech.integration.rest.service;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;
import pl.lodz.p.it.bakertech.integration.util.TestOrder;
import pl.lodz.p.it.bakertech.validation.Messages;

import java.util.List;
import java.util.Optional;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;
import static pl.lodz.p.it.bakertech.integration.util.TestOrder.*;

public class OrdersDisplayTests extends BakerTechIntegrationTestConfig {
    public static List<TestOrder> allOrders() {
        return List.of(NON_WARRANTY_REPAIR, WARRANTY_REPAIR, FIRST_CONSERVATION, SECOND_CONSERVATION);
    }

    @ParameterizedTest
    @ValueSource(strings = {"", "status", "orderType", "delayed"})
    void success_getAllOrdersTest(String queryParam) {
        Object queryParamValue;
        switch (queryParam) {
            case "status" -> queryParamValue = FIRST_CONSERVATION.status();
            case "orderType" -> queryParamValue = FIRST_CONSERVATION.orderType();
            case "delayed" -> queryParamValue = true;
            default -> queryParamValue = null;
        }

        RequestSpecification header = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()));
        if (Optional.ofNullable(queryParamValue).isPresent()) {
            header.queryParam(queryParam, queryParamValue);
        }
        Response response = header.get("/api/orders");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue((int) (response.jsonPath().get("totalElements")) > 0);
    }

    @ParameterizedTest
    @ValueSource(strings = {"", "status", "orderType", "delayed"})
    void success_getAllOrders_serviceman_Test(String queryParam) {
        Object queryParamValue;
        switch (queryParam) {
            case "status" -> queryParamValue = FIRST_CONSERVATION.status();
            case "orderType" -> queryParamValue = FIRST_CONSERVATION.orderType();
            case "delayed" -> queryParamValue = true;
            default -> queryParamValue = null;
        }

        RequestSpecification header = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()));
        if (Optional.ofNullable(queryParamValue).isPresent()) {
            header.queryParam(queryParam, queryParamValue);
        }
        Response response = header.get("/api/orders/assigned-to-serviceman");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue((int) (response.jsonPath().get("totalElements")) > 0);
    }

    @Test
    void success_getAllOrders_client_Test() {
        Response response = given()
                .header(keycloakJwtToken(CYPRIAN_BANINO.username(), CYPRIAN_BANINO.password()))
                .queryParam("client", CYPRIAN_BANINO.username())
                .get("/api/orders");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue((int) (response.jsonPath().get("totalElements")) > 0);
    }

    @Test
    void success_getOrdersQueueTest() {
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .get("/api/orders/orders-queue");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertTrue((int) (response.jsonPath().get("totalElements")) > 0);
    }

    @ParameterizedTest
    @MethodSource("allOrders")
    void success_getOrderTest(TestOrder order) {
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .get("/api/orders/%s".formatted(order.id()));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertEquals(order.status().toString(), response.jsonPath().get("status").toString());
        Assertions.assertEquals(order.orderType().toString(), response.jsonPath().get("orderType").toString());
        Assertions.assertEquals(eTagGenerator.generateETagValue(order), response.getHeaders().get("ETag").getValue());
    }

    @Test
    void success_getNextConservationForOrderTest() {
        Response response = given()
                .header(keycloakJwtToken(CYPRIAN_BANINO.username(), CYPRIAN_BANINO.password()))
                .get("/api/orders/%s/next-conservation".formatted(FIRST_CONSERVATION.id()));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
    }

    @Test
    void error_getAllOrdersNotForSelf_client_Test() {
        Response response = given()
                .header(keycloakJwtToken(CYPRIAN_BANINO.username(), CYPRIAN_BANINO.password()))
                .queryParam("client", DAWID_JASPER.username())
                .get("/api/orders");
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.errorForbidden, response.jsonPath().get("message"));
    }

    @Test
    void error_getNextConservationForOrderTestNotForSelf_client_Test() {
        Response response = given()
                .header(keycloakJwtToken(DAWID_JASPER.username(), DAWID_JASPER.password()))
                .get("/api/orders/%s/next-conservation".formatted(FIRST_CONSERVATION.id()));
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.errorForbidden, response.jsonPath().get("message"));
    }
}
