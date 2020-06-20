# Docker Compose

This chapter introduces the concept of an application consisting of multiple services, each running in a container, and how Docker Compose allows us to easily build, run, and scale such an application using a declarative approach.

## This chapter covers the following topics:

- Demystifying declarative versus imperative
- Running a multi-service application
- Scaling a service
- Building and pushing an application
- Using Docker Compose overrides


## Build web and db container

```
 cd ~\docker-compose\database\
 docker image build -t fredysa/db:1.0 .

 cd ~\docker-compose\web
docker image build -t fredysa/web:1.0 .

docker image ls


```
## You need to have **docker-compose** installed on your system. 

This is automatically the case if you have installed Docker for Desktop or Docker Toolbox on your Windows or macOS computer. 

Otherwise, you can find detailed installation instructions here: https://docs.docker.com/compose/install/

- [Demystifying declarative versus imperative](demystifying-declarative-versus-imperative.md)
- [Running a multi-service application](running-a-multi-service-application.md)
- [Building and pushing an application](building-and-pushing-an-application.md)
- [Using Docker Compose overrides](Using-Docker-Compose-overrides.md)

The following links provide additional information on the topics discussed in this chapter:

- The official YAML website: http://www.yaml.org/
- Docker Compose documentation: http://dockr.ly/1FL2VQ6
- Compose file version 2 reference: http://dohttps://docs.docker.com/compose/compose-file/compose-file-v2/
- Share Compose configurations between files and projects: https://docs.docker.com/compose/extends/