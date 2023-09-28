FROM maven:3.9.4-jdk-11-slim
COPY src /home/app/srcbuild
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:11.0.6-jre
EXPOSE 9096
#ADD target/location-0.0.1-SNAPSHOT.jar  location-0.0.1-SNAPSHOT.jar
COPY --from=build /home/app/target/location-0.0.1-SNAPSHOT.jar location-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar" , "location-0.0.1-SNAPSHOT.jar"]