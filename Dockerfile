# Use Maven with JDK 21 to build the application
FROM maven:3.9.5-eclipse-temurin-21 AS build

WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight JDK 21 image to run the app
FROM eclipse-temurin:21-jre-alpine
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]
