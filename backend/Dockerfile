FROM maven:3.8.4-openjdk-17-slim

RUN apt-get update && \
    apt-get install -y docker

COPY  target/bakertech-0.0.1-SNAPSHOT.jar "baker-tech.jar"

EXPOSE 8080
CMD ["java", "-jar", "baker-tech.jar"]