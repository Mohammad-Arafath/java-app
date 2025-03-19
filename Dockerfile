# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy source code
COPY src /app/src

# Compile the Java application
RUN javac src/main/java/com/example/Main.java -d /app/classes

# Set the command to run the application
CMD ["java", "-cp", "classes", "com.example.Main"]
