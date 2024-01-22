package pl.lodz.p.it.bakertech.integration.rest.service;

import io.restassured.response.Response;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.http.HttpStatus;
import pl.lodz.p.it.bakertech.integration.config.BakerTechIntegrationTestConfig;

import pl.lodz.p.it.bakertech.integration.util.TestServiceParam;

import java.util.List;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.util.TestAccount.*;
import static pl.lodz.p.it.bakertech.integration.util.TestServiceParam.CUT_OFF_DATE_PERIOD;
import static pl.lodz.p.it.bakertech.integration.util.TestServiceParam.UNIT_COST_OF_WORKING_HOUR;

public class ServiceParamsDisplayTests extends BakerTechIntegrationTestConfig {
    public static List<TestServiceParam> allParams() {
        return List.of(CUT_OFF_DATE_PERIOD, UNIT_COST_OF_WORKING_HOUR);
    }

    @Test
    void success_getAllServiceParamsTest() {
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .get("/api/service-parameters");
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertEquals(2, response.jsonPath().getList("$").size());
    }

    @ParameterizedTest
    @MethodSource("allParams")
    void success_getServiceParamTest(TestServiceParam parameter) {
        Response response = given()
                .header(keycloakJwtToken(BAKERTECH_ADMIN.username(), BAKERTECH_ADMIN.password()))
                .when()
                .get("/api/service-parameters/%s".formatted(parameter.id()));
        Assertions.assertEquals(HttpStatus.OK.value(), response.getStatusCode());
        Assertions.assertEquals(eTagGenerator.generateETagValue(parameter), response.getHeaders().get("ETag").getValue());
    }
}
