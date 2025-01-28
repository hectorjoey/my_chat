##
## Build stage
##
#FROM maven:3.8.2-jdk-8 AS build
#COPY . .
#RUN mvn clean package -DskipTests
#
##
## Package stage
##
#FROM openjdk:8-jdk-slim
#COPY --from=build /target/assetverify-0.0.1-SNAPSHOT.jar assetverify-0.0.1-SNAPSHOT.jar
## ENV PORT=8080
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","assetverify-0.0.1-SNAPSHOT.jar"]
#
# Build stage
#
FROM maven:3.8.2-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-jdk-slim
COPY --from=build /target/spring-ollama-0.0.1-SNAPSHOT.jar spring-ollama-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","spring-ollama-0.0.1-SNAPSHOT.jar"]