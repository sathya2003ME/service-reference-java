# Use official JDK 21 as build stage
FROM gradle:8.10.2-jdk21 AS build
WORKDIR /app

# Copy source code
COPY . .

# Build the Spring Boot jar (skip tests for faster build if you want)
RUN ./gradlew clean bootJar -x test

# ----------------------------
# Run stage
# ----------------------------
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/build/libs/service-reference-java-0.0.1-SNAPSHOT.jar app.jar

# Expose Spring Boot port
EXPOSE 9090

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
