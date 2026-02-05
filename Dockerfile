FROM openjdk:17-jdk-slim

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN ./mvnw clean compile -DskipTests

EXPOSE 8080

ENTRYPOINT ["./mvnw", "spring-boot:run"]