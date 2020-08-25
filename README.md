# k8s-cluster ⚓️

A system administration and networking project. Create and deploy a complete [Kubernetes](https://kubernetes.io/) cluster. The aim of this project is to introduce to Kubernetes by creating a self managed cluster to play with in a local environment.


## Installation

First of all, you will need sto have previously installed:

- [Docker](https://www.docker.com/)
- [VitrualBox](https://www.virtualbox.org/)

After installing dependencies just run the installation script. This script will automatically create the cluster, all Docker images, deployments, services and persistent volumes needed to run the cluster. 

```bash
./setup.sh
```

Once finished you will get a list of all services with their corresponding ips and ports

## Specs

The following specifications are included in this project:

- The **cluster is set up with [minikube](https://minikube.sigs.k8s.io/docs/start/)**. This choice is made due to having MacOS as local environment and LoadBalancer as service. Using any multinode/Docker based solution as [kind](https://kind.sigs.k8s.io/docs/user/quick-start/) would only work on Linux since you cannot connect to Docker bridge's network from a MacOS host.

- As said, the **service type is LoadBalancer**. Since we are running local and don't have access to any Cloud Provided tooling this service is implemented with [MetalLB](https://metallb.universe.tf/)

- **Persistence volumes** are use to ensure all the services keep running despite any technical issues.

## Featuring services

The services running are:
- **Nginx server** with http, https and ssh connections
- **MySQL Database**
- **Wordpress**
- **PhpMyAdmin**
- **Grafana dashboard**
- **InfluxDB Database**
- **FTPS server**

## Some detailed comments

- [x] Telegraf is used to provide all the data from services to InfluxDB. This is done by connecting it directly to Docker socket `endpoint = "unix:///var/run/docker.sock"` which allows us to retreive the data from all applications runngin without having to install it on every single pod.

- [x] All the images are created using Minikube's Docker daemon. To enable this you have to locally export some variables `eval $(minikube -p minikube docker-env)`
