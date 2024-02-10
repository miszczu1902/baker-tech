package pl.lodz.p.it.bakertech.integration.rest.service;

import io.restassured.http.ContentType;
import io.restassured.http.Header;
import io.restassured.response.Response;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.EnumSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;
import pl.lodz.p.it.bakertech.model.service.orders.types.OrderType;
import pl.lodz.p.it.bakertech.service.dto.orders.create.CreateOrderDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.create.NextOrderDataDTO;
import pl.lodz.p.it.bakertech.service.dto.orders.update.UpdateOrderDTO;
import pl.lodz.p.it.bakertech.utils.DateUtility;
import pl.lodz.p.it.bakertech.validation.Messages;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;
import static pl.lodz.p.it.bakertech.integration.util.TestOrder.*;

public class OrdersModificationDataTests extends BakerTechIntegrationTestConfig {
    @BeforeEach
    public void initTest() {
        initDb();
    }

    @Test
    void success_assignOrderToServicemanTest() {
        String url = "/api/orders/%s/assign-serviceman".formatted(-27);
        String eTagUrl = "/api/orders/%s".formatted(-27);
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag(eTagUrl, CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @ParameterizedTest
    @EnumSource(OrderType.class)
    void success_createOrderTest(OrderType orderType) {
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(ORDER_TO_CREATE(orderType))
                .post("/api/orders");
        Assertions.assertEquals(HttpStatus.CREATED.value(), response.getStatusCode());
        String id = response.getHeaders()
                .get("Location")
                .getValue()
                .replace("http://localhost:3000/orders/", "");

        response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .get("/api/orders/%s".formatted(id));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
    }

    @Test
    void error_cannotCreateWarrantyRepairWithInvalidDateTest() {
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new CreateOrderDTO(
                        DAWID_JASPER.username(),
                        "Testowe zlecenie",
                        OrderType.WARRANTY_REPAIR,
                        new NextOrderDataDTO(DateUtility.nowWithoutTimestamp(true).plusMonths(3), null)
                ))
                .post("/api/orders");
        Assertions.assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.validationViolation, response.jsonPath().get("message"));
    }

    @ParameterizedTest
    @EnumSource(OrderType.class)
    void success_editOrderTest(OrderType orderType) {
        success_createOrderTest(orderType);

        String url = "/api/orders/1/assign-serviceman";
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag("/api/orders/1", CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag("/api/orders/1", CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new UpdateOrderDTO(SETTLE_ORDER(orderType), null))
                .patch("/api/orders/1");
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag("/api/orders/1", BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new UpdateOrderDTO(null, CLOSE_ORDER(false)))
                .patch("/api/orders/1");
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }

    @Test
    void error_cannotCreateConservationWithInvalidDateTest() {
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new CreateOrderDTO(
                        DAWID_JASPER.username(),
                        "Testowe zlecenie",
                        OrderType.CONSERVATION,
                        new NextOrderDataDTO(null,
                                DateUtility.nowWithoutTimestamp(true).minusMonths(3))
                ))
                .post("/api/orders");
        Assertions.assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.validationViolation, response.jsonPath().get("message"));
    }


    @Test
    void error_cannotAssignOrderWhichWasAssignedTest() {
        success_assignOrderToServicemanTest();
        String url = "/api/orders/%s/assign-serviceman".formatted(-27);
        Header eTag = eTag("/api/orders/%s".formatted(-27), CARL_JOHNSON.username(), CARL_JOHNSON.password());
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag)
                .when()
                .post(url);
        Assertions.assertEquals(HttpStatus.NOT_FOUND.value(), response.getStatusCode());
    }

    @Test
    void error_cannotCloseSelfExecutedOrderTest() {
        success_createOrderTest(OrderType.WARRANTY_REPAIR);
        String url = "/api/orders/1";
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag(url, CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .post("/api/orders/1/assign-serviceman");
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag(url, CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new UpdateOrderDTO(SETTLE_ORDER(OrderType.WARRANTY_REPAIR), null))
                .patch(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag(url, CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new UpdateOrderDTO(null, CLOSE_ORDER(false)))
                .patch(url);
        Assertions.assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.cannotSettleOrder, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotVerifyETagTest() {
        success_createOrderTest(OrderType.CONSERVATION);
        Header eTag = eTag("/api/orders/1", CARL_JOHNSON.username(), CARL_JOHNSON.password());
        Response response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag)
                .when()
                .contentType(ContentType.JSON)
                .body(new UpdateOrderDTO(SETTLE_ORDER(OrderType.CONSERVATION), null))
                .post("/api/orders/1/assign-serviceman");
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());

        response = given()
                .header(keycloakJwtToken(CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .header(eTag("/api/orders/-1", CARL_JOHNSON.username(), CARL_JOHNSON.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new UpdateOrderDTO(SETTLE_ORDER(OrderType.CONSERVATION), null))
                .patch("/api/orders/1");
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.contentChanged, response.jsonPath().get("message"));
    }
}