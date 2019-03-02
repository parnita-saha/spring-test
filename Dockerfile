FROM maven:3.5-jdk-8-alpine as build
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn clean install

FROM openjdk:8-jdk-alpine
EXPOSE 8763
COPY --from=build /target/demo-spring-boot-docker-0.1.0.jar ./demo-spring-boot-docker.jar
ENTRYPOINT ["java","-jar","./demo-spring-boot-docker.jar"]
