FROM maven:3.8.4-openjdk-17-slim AS builder
WORKDIR /bakertech-api
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests=true

FROM openjdk:17
WORKDIR /bakertech-api
COPY --from=builder /bakertech-api/target/*.jar bakertech-api.jar
ENTRYPOINT ["java", "-jar", "bakertech-api.jar"]