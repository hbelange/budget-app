# Build stage
FROM eclipse-temurin:21-jdk-alpine AS build

WORKDIR /build

# Copy Maven wrapper and pom.xml
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# This line is required to fix the permission error
RUN chmod +x ./mvnw

# Download dependencies (cached layer)
RUN ./mvnw dependency:go-offline

# Copy source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-alpine AS runtime

# Define few things
ARG APP_VERSION=1.0.0

WORKDIR /app

# Copy the JAR file from build stage
COPY --from=build /build/target/BudgetApp-*.jar /app/

# Expose application port
EXPOSE 8080

ENV DB_URL=jdbc:postgresql://budget-app-postgres:5432/budgetapp
ENV JAR_VERSION=${APP_VERSION}
ENV EMAIL_HOSTNAME=missing_hostname
ENV EMAIL_USERNAME=missing_username
ENV EMAIL_PASSWORD=missing_password

# Run application
CMD java -jar -Dspring.datasource.url=${DB_URL} BudgetApp-${JAR_VERSION}.jar