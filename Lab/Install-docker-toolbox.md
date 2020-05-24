Docker Toolbox is a great addition even when you normally use Docker for Desktop for your development with Docker. Docker Toolbox allows you to create multiple Docker hosts (or VMs) in VirtualBox and connect them to a cluster, on top of which you can run Docker Swarm or Kubernetes.

If Hyper-V was previosly installed
![Disable Hyper-V](Fix-HyperV-VirtualBox-Docker-Tools.png)
```dos
bcdedit /set hypervisorlaunchtype off
```

### Prerequisite Instal Choco, Git, VSCode 

##  Install  VirtualBox

choco install virtualbox -y


# Install Docker Toolbox

https://github.com/docker/toolbox/releases

```powershell
choco install docker-toolbox -y --force 

docker-compose --version
docker-machine --version
```

## List of all Docker-ready VMs


```powershell
docker-machine ls
```

# If no default !
## Create new docker VM

```dockerfile

docker-machine -D create --driver virtualbox default
```

## Let's use docker-machine to start this VM so we can work with it:

```dockerfile
docker-machine -D start default
```

## Troubleshoot cmd

```dockerfile
docker-machine --help
docker-machine inspect default
docker-machine -D regenerate-certs default
docker-machine restart default
docker-machine rm default
```


## Check machine 

```dockerfile
docker-machine env default
```

## Create Hello-World

```dockerfile
docker run hello-world
```


