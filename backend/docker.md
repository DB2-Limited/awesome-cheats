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

## Dockerfile
List of instructions which Docker Client will run to build an image.
Consider this `Dockerfile` as reference:
```
FROM ubuntu:18.10
COPY . /app
CMD python /app/app.py
```
Each instruction starts from the new line with some command. (e.g. `FROM`, `COPY`, `CMD`)
In this example:
- `FROM` - define which Docker image use as a skeleton, in this case it's `ubuntu:18.10`
- `COPY` - copy everything in `.` to `/app`
- `CMD` - define command to run application in Docker container
Please read the [most common commands](https://docs.docker.com/engine/reference/builder/#from) for the `Dockerfile` (`FROM`, `LABEL`, `RUN`, `WORKDIR`, `COPY`, `EXPOSE`, `ENV`, `CMD`)

## Useful commands
### Build
If you want to build custom Docker container with your defined `Dockerfile` run:  
```
docker build .
```
You can also specify container name and tag by running:  
```
docker build -t <container_name>:<tag> .
```  
Docker Client will send the build context to the Docker daemon and run each command from your `Dockerfile`.  

### List
If you want to list all running docker containers in your computer just run:
```
docker ps
```
You can also list all(include stopped) containers with `--all` flag:
```
docker ps --all
```

### Run
To run already builded docker container enter:
```
docker run <container_name>:<tag>
```
You can also map your local ports with docker container exposed ports by adding `-p` flag:
```
docker run -p <local_port>:<docker_port> <container_name>:<tag>
```
Also it's a good to know, that you allowed to use `-i` and `-t` flags which give you possibility to keep STDIN open and also adds pseudo-tty.
```
docker run -it -p <local_port>:<docker_port> <container_name>:<tag>
```

### Stop
For the regular stop:
```
docker stop <container_name>
```
For the immediate stop:
```
docker kill <container_name>
```

### Remove images & containers
For all images:
```
docker rmi $(docker images -q)
```
For all containers:
```
docker rm $(docker ps -aq)
```

### Execute custom command
Due to `-i` and `-t` flags you have opportunity to run custom commands inside the running docker container (e.g. `bash`)
```
docker exec -it <container_name> bash
```

## References
- [Docker Hub](https://hub.docker.com)
- [Docker Docs](https://docs.docker.com/)
- [Play with docker](https://training.play-with-docker.com/)
- [Play with Moby](http://play-with-moby.com/)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker run reference](https://docs.docker.com/engine/reference/run/)
