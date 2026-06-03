# 1. Base image (Java runtime environment)
FROM eclipse-temurin:17-jdk-alpine

# 2. Set working directory inside container
WORKDIR /app

# 3. Copy Maven wrapper (optional but recommended)
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# 4. Give permission to Maven wrapper
RUN chmod +x mvnw

# 5. Download dependencies (cached layer optimization)
RUN ./mvnw dependency:go-offline

# 6. Copy application source code
COPY src ./src

# 7. Build the application (skip tests for faster build)
RUN ./mvnw clean package -DskipTests

# 8. Rename jar for simplicity (optional but clean)
RUN cp target/*.jar app.jar

# 9. Expose application port
EXPOSE 8080

# 10. Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]