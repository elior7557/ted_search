
FROM openjdk:8-slim

COPY ./target /app
COPY ./application.properties /app

WORKDIR /app

ENTRYPOINT ["java", "-jar", "./embedash-1.1-SNAPSHOT.jar","--spring.confog.location=./application.properties", "--server.port=8080"]

