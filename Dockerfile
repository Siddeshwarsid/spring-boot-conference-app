FROM adoptopenjdk/openjdk11:alpine-slim as build

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests

FROM adoptopenjdk/openjdk11:alpine-jre
COPY --from=build target/conference-demo-0.0.1-SNAPSHOT.jar conference-demo.jar

ENTRYPOINT ["java", "-jar", "conference-demo.jar"]