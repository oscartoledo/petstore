FROM eclipse-temurin:17-jdk-alpine AS BUILDER

ARG PROJECT_DIR=./

COPY *.gradle gradle.* gradlew /app/
COPY gradle /app/gradle
WORKDIR /app

COPY ${PROJECT_DIR} /app
WORKDIR /app
RUN ./gradlew --no-daemon --info --build-cache --parallel build -x test 
RUN ./gradlew --no-daemon --info --build-cache bootJar

FROM eclipse-temurin:17-jre-alpine
ARG PROJECT_NAME=petstore

COPY --from=BUILDER /app/build/libs/${PROJECT_NAME}.jar /app/app.jar

WORKDIR /
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod -R 755 ./docker-entrypoint.sh

RUN addgroup -S app && adduser -S -G app app
RUN chmod -R 777 /app
USER app

EXPOSE 8080

ENTRYPOINT ["./docker-entrypoint.sh"]