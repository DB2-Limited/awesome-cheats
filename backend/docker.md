# Docker

<p align="center">
  <img src="./assets/docker.png">
</p>

**Docker** - tool that performs containerization on operating-system level. It uses the resource isolation features of the Linux kernel to allow independent containers to run within a single Linux instance, avoiding the overhead of starting and management virtual machines. It is developed by [Docker, Inc](https://docker.com/).

## Components

### Docker Daemon
**dockerd** - docker daemon, persistent process that manages Docker containers and handles container objects. Daemon listens for requests sent via the Docker Engine API. The command `docker` allows user to interact with Docker daemons with command line interface (CLI).

### Docker objects
**Container** - isolated environment that runs application. A container is managed from Docker API or CLI.  
**Image** - read-only template used to build containers. Images used to build and distribute applications.

### Registries
**Registry** - repository for Docker images. Docker client can pull & push images from & to registry. Registry can be public(no need to sign in to pull/push images) or private(auth is required). The default registry for each docker client is [Docker Hub](https://hub.docker.com), but docker client can be configured to use any other docker registry ([AWS ECR](https://aws.amazon.com/ecr/), [Azure CR](https://azure.microsoft.com/en-us/services/container-registry/), [Gitlab CR](http://docs.gitlab.com/ee/administration/container_registry.html) and others).

<p align="center">
  <img src="./assets/components-flow.png">
</p>

## Tools

### Docker Compose
[Tool](https://docs.docker.com/compose/) that helps define, manage and run multi-container Docker applications. It uses [YAML](https://en.wikipedia.org/wiki/YAML) files to setup the applications and perform a start-up process with a single command. [docker-compose](https://docs.docker.com/compose/reference/) CLI utility allows users to run commands on multiple containers at the same time (e.g. building, scale, run, stop etc). The [docker-compose.yml](https://docs.docker.com/compose/compose-file/) file is used to define an application's services.

### Docker Swarm
Clustering functionality for Docker. Unites a few Docker engines into a single virtual one. [Swarm](https://docs.docker.com/engine/swarm/) CLI utility allows users to manage cluster nodes and containers.


## Docker container vs Virtual machine

<p align="center">
  <img src="./assets/container.png" width=300>
  <img src="./assets/virtual-machine.png" width=300>
</p>
