FROM ghcr.io/graalvm/graalvm-ce:ol7-java11-22.3.0 as builder

# Set the working directory to /home/app
WORKDIR /build

# Copy the source code into the image for building
COPY . /build

RUN cd target && gu install native-image && native-image -jar spring-boot-rest-example-0.0.1-SNAPSHOT.jar spring-boot-graal


FROM ghcr.io/graalvm/graalvm-ce:ol7-java11-22.3.0 as runner

EXPOSE 8080

# Add Spring Boot Native app spring-boot-graal to Container
COPY --from=builder "/build/target/*" .

# Fire up our Spring Boot Native app by default
CMD ./spring-boot-graal