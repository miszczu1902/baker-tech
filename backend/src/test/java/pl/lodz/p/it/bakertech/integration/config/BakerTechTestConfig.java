package pl.lodz.p.it.bakertech.integration.config;

import io.github.cdimascio.dotenv.Dotenv;
import io.restassured.RestAssured;
import io.restassured.http.Header;
import io.restassured.parsing.Parser;
import io.restassured.response.Response;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

import static io.restassured.RestAssured.given;

@Slf4j
@Testcontainers
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public abstract class BakerTechTestConfig {
    @LocalServerPort
    int port;

    public static int keycloakPort;

    @Value("${spring.security.oauth2.client.registration.keycloak.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.keycloak.client-secret}")
    private String clientSecret;

    private static final Path dotEnvPath = Paths.get("src/test/resources").toAbsolutePath();
    private static final Path dropSqlFilePath = Paths.get("src/test/resources/sql/dropDb.sql").toAbsolutePath();
    private static final Path dbDirPath = Paths.get("db").toAbsolutePath();
    private static final Path initDbPath = Paths.get("db/init_structure.sh").toAbsolutePath();
    protected static Dotenv dotenv = Dotenv.configure()
            .directory(dotEnvPath.toString())
            .filename(".env")
            .load();

    @Container
    protected static PostgreSQLContainer<?> postgresContainer = new PostgreSQLContainer<>("postgres:15")
            .withExposedPorts(5432)
            .withDatabaseName(dotenv.get("POSTGRES_DATABASE"))
            .withUsername(dotenv.get("POSTGRES_USER"))
            .withPassword(dotenv.get("POSTGRES_PASSWORD"))
            .withFileSystemBind(dbDirPath.toString(), "/home/db")
            .withFileSystemBind(initDbPath.toString(), "/docker-entrypoint-initdb.d/init_structure.sh")
            .withFileSystemBind(dropSqlFilePath.toString(), "/home/drop/dropDb.sql")
            .waitingFor(Wait.forListeningPort());

    @Container
    protected static GenericContainer<?> keycloakContainer = new GenericContainer<>("quay.io/keycloak/keycloak:22.0.5")
            .withExposedPorts(8080)
            .withEnv("KC_HEALTH_ENABLED", dotenv.get("KC_HEALTH_ENABLED"))
            .withEnv("KC_METRICS_ENABLED", dotenv.get("KC_METRICS_ENABLED"))
            .withEnv("KC_DB", dotenv.get("KC_DB"))
            .withEnv("KC_DB_SCHEMA", dotenv.get("KC_DB_SCHEMA"))
            .withEnv("KC_DB_URL", dotenv.get("KC_DB_URL"))
            .withEnv("KC_DB_USERNAME", dotenv.get("KC_DB_USERNAME"))
            .withEnv("KC_DB_PASSWORD", dotenv.get("KC_DB_PASSWORD"))
            .withEnv("KEYCLOAK_ADMIN", dotenv.get("KEYCLOAK_ADMIN"))
            .withEnv("KEYCLOAK_ADMIN_PASSWORD", dotenv.get("KEYCLOAK_ADMIN_PASSWORD"))
            .withCommand("start-dev")
            .waitingFor(Wait.forLogMessage(".*Listening on.*", 1));

    static {
        try (Network network = Network.newNetwork()) {
            postgresContainer.withNetwork(network).withNetworkAliases("db");
            keycloakContainer.withNetwork(network).withNetworkAliases("keycloak");
            postgresContainer.start();
            keycloakContainer.start();
            keycloakPort = keycloakContainer.getMappedPort(8080);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        RestAssured.baseURI = "http://localhost";
        RestAssured.defaultParser = Parser.JSON;
        RestAssured.enableLoggingOfRequestAndResponseIfValidationFails();
        RestAssured.useRelaxedHTTPSValidation();
    }

    @DynamicPropertySource
    static void configProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgresContainer::getJdbcUrl);
        registry.add("spring.datasource.username", postgresContainer::getUsername);
        registry.add("spring.datasource.password", postgresContainer::getPassword);
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

    protected Response auth(final String username, final String password) {
        Response response = given()
                .port(keycloakPort)
                .header("Content-Type", "application/x-www-form-urlencoded")
                .formParam("username", username)
                .formParam("password", password)
                .formParam("grant_type", "password")
                .formParam("client_id", clientId)
                .formParam("client_secret", clientSecret)
                .when()
                .post("/realms/BakerTech/protocol/openid-connect/token");
        log.info("\nUsername: %s\n Login response: %s".formatted(username, response.asPrettyString()));
        return response;

    }

    protected Header keycloakJwtToken(final String username, final String password) {
        String token = "Bearer %s" .formatted(
                auth(username, password)
                        .jsonPath()
                        .getString("access_token"));
        log.info("\nUsername: %s \nJWT: %s".formatted(username, token));
        return new Header("Authorization", token);
    }

    @BeforeEach
    public void initPortForRestAssured() {
        RestAssured.port = port;
    }
}