package pl.lodz.p.it.bakertech.integration.config;

import io.github.cdimascio.dotenv.Dotenv;
import io.restassured.RestAssured;
import io.restassured.parsing.Parser;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Container;

import java.nio.file.Path;
import java.nio.file.Paths;

public class TestEnvContainers {
    private static final Path dotEnvPath = Paths.get("src/test/resources").toAbsolutePath();
    private static final Path dropSqlFilePath = Paths.get("src/test/resources/sql/dropDb.sql").toAbsolutePath();
    private static final Path dbDirPath = Paths.get("db").toAbsolutePath();
    private static final Path initDbPath = Paths.get("db/init_structure.sh").toAbsolutePath();

    protected static Dotenv dotenv = Dotenv.configure()
            .directory(dotEnvPath.toString())
            .filename(".env")
            .load();

    public static int keycloakPort;

    @Container
    public static PostgreSQLContainer<?> postgresContainer = new PostgreSQLContainer<>("postgres:15")
            .withExposedPorts(5432)
            .withDatabaseName(dotenv.get("POSTGRES_DATABASE"))
            .withUsername(dotenv.get("POSTGRES_USER"))
            .withPassword(dotenv.get("POSTGRES_PASSWORD"))
            .withFileSystemBind(dbDirPath.toString(), "/home/db")
            .withFileSystemBind(initDbPath.toString(), "/docker-entrypoint-initdb.d/init_structure.sh")
            .withFileSystemBind(dropSqlFilePath.toString(), "/home/drop/dropDb.sql")
            .waitingFor(Wait.forListeningPort());

    @Container
    public static GenericContainer<?> keycloakContainer = new GenericContainer<>("quay.io/keycloak/keycloak:22.0.5")
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
}
