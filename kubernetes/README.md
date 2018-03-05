# Ballerina Docker/Kubernetes samples


## Prerequisites
 1. Install a recent version of Docker for Mac and [enable Kubernetes](https://docs.docker.com/docker-for-mac/#kubernetes)
 2. Nginx backend controllers deployed.

#### Setup nginx-ingress

1. Run the following command to deploy nginx backend.

```
kubectl apply -f nginx-ingress/namespaces/nginx-ingress.yaml -Rf nginx-ingress
```

