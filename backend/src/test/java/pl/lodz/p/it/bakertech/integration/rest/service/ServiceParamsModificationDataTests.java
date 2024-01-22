package pl.lodz.p.it.bakertech.integration.rest.service;

import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;
import pl.lodz.p.it.bakertech.service.dto.parameters.ModifyServiceParameterDTO;
import pl.lodz.p.it.bakertech.validation.Messages;

import java.math.BigDecimal;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.BAKERTECH_ADMIN;
import static pl.lodz.p.it.bakertech.integration.util.TestServiceParam.CUT_OFF_DATE_PERIOD;
import static pl.lodz.p.it.bakertech.integration.util.TestServiceParam.UNIT_COST_OF_WORKING_HOUR;

public class ServiceParamsModificationDataTests extends BakerTechIntegrationTestConfig {
    @BeforeEach
    public void initTest() {
        initDb();
    }

    @Test
    void success_changeParamValueTest() {
        String url = "/api/service-parameters/%s".formatted(CUT_OFF_DATE_PERIOD.id());
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(url, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new ModifyServiceParameterDTO(new BigDecimal("4")))
                .patch(url);
        Assertions.assertEquals(HttpStatus.NO_CONTENT.value(), response.getStatusCode());
    }
    
    @Test
    void error_invalidServiceParamValueTest() {
        String url = "/api/service-parameters/%s".formatted(CUT_OFF_DATE_PERIOD.id());
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(url, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new ModifyServiceParameterDTO(new BigDecimal("-44")))
                .patch(url);
        Assertions.assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.validationViolation, response.jsonPath().get("message"));
    }

    @Test
    void error_cannotVerifyETagTest() {
        String url = "/api/service-parameters/%s".formatted(UNIT_COST_OF_WORKING_HOUR.id());
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .header(eTag(url, BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .contentType(ContentType.JSON)
                .body(new ModifyServiceParameterDTO(new BigDecimal("20")))
                .patch("/api/service-parameters/%s".formatted(CUT_OFF_DATE_PERIOD.id()));
        Assertions.assertEquals(HttpStatus.CONFLICT.value(), response.getStatusCode());
        Assertions.assertEquals(Messages.contentChanged, response.jsonPath().get("message"));
    }
}