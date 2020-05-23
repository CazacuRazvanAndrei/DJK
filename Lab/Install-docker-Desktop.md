# Instal Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#### If TLS is old 
Fix  run in Powershell

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
```

# Install Git


```powershell
choco install git -y
```

# Install Visual studio code

```powershell
choco install vscode -y
```

## Start VSCode

```powershell
code .
```

## Install extension VSCode


```powershell
code --install-extension docsmsft.docs-markdown
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.csharp
code --install-extension ms-python.python
code --install-extension ms-azuretools.vscode-docker
code --install-extension eamodio.gitlens
```

# Download Docker Desktop WIndows 10
 https://www.docker.com/get-started

# Check Version


```powershell
choco --version
git --version
docker --version
```

# Get Code

```powershell
git pull https://github.com/Fredy-SSA/djk
```

# Run Hello World
```powershell
docker run hello-world
```


```dockerfile
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
```


