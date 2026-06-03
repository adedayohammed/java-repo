FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy gradle wrapper
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Make wrapper executable
RUN chmod +x gradlew

# Download dependencies
RUN ./gradlew dependencies

# Copy source code
COPY src ./src

# Build project
RUN ./gradlew build -x test

# Run jar
CMD ["java", "-jar", "build/libs/demo-0.0.1-SNAPSHOT.jar"]