package pl.lodz.p.it.bakertech.integration.config;

import io.restassured.RestAssured;
import io.restassured.http.Header;
import io.restassured.response.Response;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.junit.jupiter.Testcontainers;
import pl.lodz.p.it.bakertech.validation.etag.ETagGenerator;

import java.io.IOException;
import java.util.Objects;

import static io.restassured.RestAssured.given;
import static pl.lodz.p.it.bakertech.integration.config.TestEnvContainers.*;

@Slf4j
@Testcontainers
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Tag("IntegrationTest")
public abstract class BakerTechIntegrationTestConfig {
    @LocalServerPort
    int port;

    @Autowired
    protected ETagGenerator eTagGenerator;

    @DynamicPropertySource
    static void configProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.accounts.url", postgresContainer::getJdbcUrl);
        registry.add("spring.datasource.business.url", postgresContainer::getJdbcUrl);
        registry.add("spring.security.oauth2.client.provider.keycloak.issuer-uri",
                () -> Objects.requireNonNull(dotenv.get("ISSUER_URI"))
                        .formatted(keycloakPort));
        registry.add("spring.security.oauth2.client.registration.keycloak.client-id",
                () -> (dotenv.get("CLIENT_ID")));
        registry.add("spring.security.oauth2.client.registration.keycloak.client-secret",
                () -> (dotenv.get("CLIENT_PASSWORD")));
        registry.add("spring.security.oauth2.resourceserver.jwt.issuer-uri",
                () -> Objects.requireNonNull(dotenv.get("ISSUER_URI"))
                        .formatted(keycloakPort));
        registry.add("spring.security.oauth2.resourceserver.jwt.jwk-set-uri",
                () -> Objects.requireNonNull(dotenv.get("JWK_SET_URI"))
                        .formatted(keycloakPort));
        registry.add("bakertech.keycloak.url",
                () -> Objects.requireNonNull(dotenv.get("KEYCLOAK_URL"))
                        .formatted(keycloakPort));
        registry.add("mail.enable", () -> false);
    }

    protected static Response auth(final String username, final String password) {
        Response response = given()
                .port(keycloakPort)
                .header("Content-Type", "application/x-www-form-urlencoded")
                .formParam("username", username)
                .formParam("password", password)
                .formParam("grant_type", "password")
                .formParam("client_id", dotenv.get("CLIENT_ID"))
                .formParam("client_secret", dotenv.get("CLIENT_PASSWORD"))
                .when()
                .post("/realms/BakerTech/protocol/openid-connect/token");
        log.info("\nUsername: %s\n Login response: %s".formatted(username, response.asPrettyString()));
        return response;

    }

    protected static Header keycloakJwtToken(final String username, final String password) {
        String token = "Bearer %s".formatted(
                auth(username, password)
                        .jsonPath()
                        .getString("access_token"));
        log.info("\nUsername: %s \nJWT: %s".formatted(username, token));
        return new Header("Authorization", token);
    }

    protected static Header eTag(final String url, final String username, final String password) {
        String eTag = given()
                .header(keycloakJwtToken(username, password))
                .when()
                .get(url)
                .getHeaders()
                .getValue("ETag");
        log.info("\nETag: %s".formatted(eTag));
        return new Header("If-Match", eTag);
    }

    public static void initDb() {
        try {
            postgresContainer.execInContainer("psql", "-U", "bakertech", "-f", "/home/drop/dropDb.sql");
            postgresContainer.execInContainer("/home/db/init_structure.sh");
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    @BeforeEach
    public void initPortForRestAssured() {
        RestAssured.port = port;
    }
}