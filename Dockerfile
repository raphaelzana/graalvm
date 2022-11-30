### BUILD image
FROM maven:3-jdk-8 as builder
# create app folder for sources
RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build
#Download all required dependencies into one layer
RUN mvn -B dependency:resolve dependency:resolve-plugins
#Copy source code
COPY src /build/src
# Build application
RUN mvn clean package


FROM ghcr.io/graalvm/graalvm-ce:ol7-java11-22.3.0 as nativer

# Set the working directory to /home/app
WORKDIR /build

COPY --from=builder "/build/target/*" /build

RUN gu install native-image && native-image -jar spring-boot-rest-example-0.0.1-SNAPSHOT.jar spring-boot-graal




FROM ghcr.io/graalvm/graalvm-ce:ol7-java11-22.3.0 as runner

EXPOSE 8080

# Add Spring Boot Native app spring-boot-graal to Container
COPY --from=nativer "/build/*" .

# Fire up our Spring Boot Native app by default
CMD ./spring-boot-graal