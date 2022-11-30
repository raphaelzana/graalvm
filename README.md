# graalvm
GraalVM POC

docker build -t spring-boot-graalvm-from-jar:1.0 .

docker run --name spring-boot-graalvm-from-jar -p 8080:8080 -t spring-boot-graalvm-from-jar:1.0
