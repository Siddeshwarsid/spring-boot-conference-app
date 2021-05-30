FROM adoptopenjdk/openjdk11:alpine-slim as build

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN ./mvnw dependency:go-offline

COPY src src
RUN ./mvnw package -DskipTests

FROM adoptopenjdk/openjdk11:alpine-jre as layers

COPY --from=build target/conference-demo-0.0.1-SNAPSHOT.jar conference-demo.jar
RUN java -Djarmode=layertools -jar conference-demo.jar extract

FROM adoptopenjdk/openjdk11:alpine-jre

COPY --from=layers dependencies/ .
COPY --from=layers snapshot-dependencies/ .
COPY --from=layers spring-boot-loader/ .
COPY --from=layers application/ .

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]