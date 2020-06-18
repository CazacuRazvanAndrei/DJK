# Running the first container
Before we start, we want to make sure that Docker is installed correctly on your system and ready to accept your commands. Open a new Terminal window and type in the following command:

```
PS > docker version
```
- **Tip:** If you are using Docker Toolbox then use the Docker Quickstart Terminal that has been installed with the Toolbox, instead of the Terminal on macOS or Powershell on Windows.
If everything works correctly, you should see the version of Docker client and server installed on your laptop output in the Terminal. At the time of writing, it looks like this (shortened for readability):

```
Client: Docker Engine - Community
 Version: 19.03.0-beta3
 API version: 1.40
 Go version: go1.12.4
 Git commit: c55e026
 Built: Thu Apr 25 19:05:38 2019
 OS/Arch: darwin/amd64
 Experimental: false

Server: Docker Engine - Community
 Engine:
 Version: 19.03.0-beta3
 API version: 1.40 (minimum version 1.12)
 Go version: go1.12.4
 Git commit: c55e026
 Built: Thu Apr 25 19:13:00 2019
 OS/Arch: linux/amd64
 ...
```

You can see that I have **beta3** of version **19.03.0** installed on my macOS.

If this doesn't work for you, then something with your installation is not right. Please make sure that you have followed the instructions in the previous chapter on how to install Docker for Desktop or Docker Toolbox on your system.

So, you're ready to see some action. Please type the following command into your Terminal window and hit Return:

```
docker container run alpine echo "Hello World" 
```
When you run the preceding command the first time, you should see an output in your Terminal window similar to this:

```
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
e7c96db7181b: Pull complete
Digest: sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6
Status: Downloaded newer image for alpine:latest
Hello World
```

Now that was easy! Let's try to run the very same command again:

```
docker container run alpine echo "Hello World" 
```
The second, third, or nth time you run the preceding command, you should see only this output in your Terminal:

```
 Hello World  
```
Try to reason about why the first time you run a command you see a different output than all of the subsequent times. But don't worry if you can't figure it out; we will explain the reasons in detail in the following sections of this chapter.