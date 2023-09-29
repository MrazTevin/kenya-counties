syntax=docker/dockerfile:1.0-experimental
FROM maven:3.9.4-eclipse-temurin-11 AS build
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app/pom.xml
RUN mvn clean
RUN --mount=type=cache,target=/root/.m2/repository mvn -e -B clean package -Dmaven.test.skip=true


FROM openjdk:11.0.6-jre
WORKDIR /home/app
#ADD target/location-0.0.1-SNAPSHOT.jar  location-0.0.1-SNAPSHOT.jar
COPY --from=build /home/app/target/location-0.0.1-SNAPSHOT.jar location-0.0.1-SNAPSHOT.jar
EXPOSE 9096
#ENTRYPOINT ["java", "-jar" , "location-0.0.1-SNAPSHOT.jar"]
CMD ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/location-0.0.1-SNAPSHOT.jar"]
