FROM arm32v7/adoptopenjdk:11.0.11_9-jdk-hotspot-focal
EXPOSE 8080
ARG JAR_FILE=target/hello-world-java.jar
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
