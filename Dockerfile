FROM arm32v7/adoptopenjdk:16.0.1_9-jdk-hotspot-focal
EXPOSE 8080
ARG JAR_FILE=target/docker-buildx-test-1.0.0.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
