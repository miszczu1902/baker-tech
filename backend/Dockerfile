FROM jelastic/maven:3.9.5-openjdk-21 as builder
WORKDIR /bakertech-api
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests=true

FROM jelastic/maven:3.9.5-openjdk-21
WORKDIR /bakertech-api
COPY --from=builder /bakertech-api/target/*.jar /bakertech-api.jar
ENTRYPOINT ["java", "-server", "-XX:+UseSerialGC", "-Xss512k", "-XX:MaxRAM=72m" , "-jar", "/bakertech-api.jar"]