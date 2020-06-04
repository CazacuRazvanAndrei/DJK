# Docker Compose

This chapter introduces the concept of an application consisting of multiple services, each running in a container, and how Docker Compose allows us to easily build, run, and scale such an application using a declarative approach.

## This chapter covers the following topics:

- Demystifying declarative versus imperative
- Running a multi-service application
- Scaling a service
- Building and pushing an application
- Using Docker Compose overrides

## After completing this chapter, the reader will be able to do the following:

- Explain in a few short sentences the main differences between an imperative and declarative approach for defining and running an application
- Describe in their own words the difference between a container and a Docker Compose service
- Author a Docker Compose YAML file for a simple multi-service application
- Build, push, deploy, and tear down a simple multi-service application using Docker Compose
- Use Docker Compose to scale an application service up and down
- Define environment-specific Docker Compose files using overrides


## You need to have **docker-compose** installed on your system. 

This is automatically the case if you have installed Docker for Desktop or Docker Toolbox on your Windows or macOS computer. 

Otherwise, you can find detailed installation instructions here: https://docs.docker.com/compose/install/

- [Demystifying declarative versus imperative](demystifying-declarative-versus-imperative.md)
- [Running a multi-service application](running-a-multi-service-application.md)
- [Building and pushing an application](building-and-pushing-an-application.md)