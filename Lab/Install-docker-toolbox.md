Docker Toolbox is a great addition even when you normally use Docker for Desktop for your development with Docker. Docker Toolbox allows you to create multiple Docker hosts (or VMs) in VirtualBox and connect them to a cluster, on top of which you can run Docker Swarm or Kubernetes.

# Install Docker Toolbox

```powershell
choco install docker-toolbox -y --force 

docker-compose --version
docker-machine --version
```

## List of all Docker-ready VMs


```powershell
docker-machine ls
```

##  Create external Virtual Switch 

```powershell
New-VMSwitch -name External  -NetAdapterName "Ethernet 2" -AllowManagementOS $true
```
## Create new docker VM

```dockerfile
docker-machine --help
docker-machine create -d hyperv --hyperv-virtual-switch "External" vmtest
```

## Let's use docker-machine to start this VM so we can work with it:

```dockerfile
docker-machine -D start vmtest
```

## Troubleshoot cmd

```dockerfile
docker-machine --help
docker-machine regenerate-certs vmtest
docker-machine restart vmtest
docker-machine rm vmtest
```


## Check machine 

```dockerfile
docker-machine env vmtest
```
