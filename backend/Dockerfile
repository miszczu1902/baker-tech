FROM jelastic/maven:3.9.5-openjdk-21
WORKDIR /bakertech-api
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests=true
ENTRYPOINT ["mvn", "spring-boot:run"]