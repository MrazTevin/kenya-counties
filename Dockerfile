FROM maven:3.9.4-eclipse-temurin-11 AS build
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app/pom.xml
RUN mvn clean
RUN --mount=type=cache,id=my-maven-cache mvn -f pom.xml clean package -Dmaven.test.skip=true



FROM openjdk:11.0.6-jre
WORKDIR /home/app
#ADD target/location-0.0.1-SNAPSHOT.jar  location-0.0.1-SNAPSHOT.jar
COPY --from=build /home/app/target/location-0.0.1-SNAPSHOT.jar location-0.0.1-SNAPSHOT.jar
EXPOSE 9096
ENTRYPOINT ["java", "-jar" , "location-0.0.1-SNAPSHOT.jar"]