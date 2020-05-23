#Instal Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#If TLS is old 
# Fix 
#[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12



# Install Git
choco install git -y

# Install Visual studio code
choco install vscode -y

#Start VSCode
code .

# install extension
code --install-extension docsmsft.docs-markdown
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.csharp
code --install-extension ms-python.python
code --install-extension ms-azuretools.vscode-docker
code --install-extension eamodio.gitlens


# Download Docker Desktop WIndows 10
# https://www.docker.com/get-started

#Version
choco --version
git --version
docker --version

# Add Repository
git remote add origin https://github.com/Fredy-SSA/djk

#Run Hello World
docker run hello-world

<#
Corect output ...
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

#>


# install Docker Toolbox
choco install docker-toolbox -y --force 

docker-compose --version
docker-machine --version

#List of all Docker-ready VMs
docker-machine ls 

#if no default create one

# CReate external Virtual Switch 
New-VMSwitch -name External  -NetAdapterName "Ethernet 2" -AllowManagementOS $true 



#Or Hyperv Driver
# -D debug 
# hyperv Hypervisor
docker-machine create -d hyperv --hyperv-virtual-switch "External" vmtest 

# Let's use docker-machine to start this VM so we can work with it:
docker-machine -D start vmtest

<#
Fix Issue
docker-machine --help
docker-machine regenerate-certs vmtest
docker-machine restart vmtest
docker-machine rm vmtest
#>
#o see how to connect your Docker client to the Docker Engine running on this virtual machine, run the following command:
docker-machine env vmtest

# DockerCLI Basic
# ! Do not Run on Powershell ISE

docker image ls
docker container ls --all
docker --help
docker container --help
docker container ls --help
docker run --help

$ eval $(docker-machine env vmtest)
$ docker version

