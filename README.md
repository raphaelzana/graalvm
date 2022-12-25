# graalvm
GraalVM POC


## Build Image With Spring Boot App With Actuator and Prometheus
docker build -t actuator .

## Build Image With Prometheus
docker build -f Dockerfile-prometheus -t prometheus .

## Create local network
docker network create docker-local-nw

## Create And Run Prometheus Container By Local Image
docker run --net=docker-local-nw -p 9090:9090 prometheus

## Create And Run Grafana Container By Remote Image
docker run --name=grafana --net=docker-local-nw -d -p 3000:3000 grafana/grafana-enterprise

## Create and Run Spring Boot App Container By Local Image
docker run --name actuator --net=docker-local-nw -p 8080:8080 -t actuator

## K8s UTIL
https://github.com/kubernetes/dashboard
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

https://learnk8s.io/spring-boot-kubernetes-guide

kubectl apply -f .

eval $(minikube -p minikube docker-env)

docker build -t spring-service -f ./Dockerfile .

minikube service loadbalancername

minikube image ls
