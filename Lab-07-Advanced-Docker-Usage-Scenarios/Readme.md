# Advanced Docker Usage Scenarios

In this section, I will present a few very useful tips and tricks that make the lives of advanced Docker users so much easier. We will start with some guidance on how to keep your Docker environment clean.

# Keeping your Docker environment clean
First, we want to learn how we can delete dangling images. According to Docker, dangling images are layers that have no relationship to any tagged images. Such image layers are certainly useless to us and can quickly fill up our disk—it's better to remove them from time to time. Here is the command:


```bash
$ docker image prune -f
```

Please note that I have added the -f parameter to the prune command. This is to prevent the CLI from asking for a confirmation that we really want to delete those superfluous layers.

Stopped containers can waste precious resources too. If you're sure that you don't need these containers anymore, then you should remove them, either individually with the following:


```bash
$ docker container rm <container-id>
```

Or, you can remove them as a batch with the following:


```bash
$ docker container prune --force
```

It is worth mentioning once again that, instead of <container-id>, we can also use <container-name> to identify a container.

Unused Docker volumes too can quickly fill up disk space. It is a good practice to tender your volumes, specifically in a development or CI environment where you create a lot of mostly temporary volumes. But I have to warn you, Docker volumes are meant to store data. Often, this data must live longer than the life cycle of a container. This is specifically true in a production or production-like environment where the data is often mission-critical. Hence, be 100% sure of what you're doing when using the following command to prune volumes on your Docker host:

```bash
$ docker volume prune
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N]
```


I recommend using this command without the **-f (or --force)** flag. It is a dangerous and terminal operation and it's better to give yourself a second chance to reconsider your action. Without the flag, the CLI outputs the warning you see in the preceding. You have to explicitly confirm by typing y and pressing the Enter key. 

On production or production-like systems, you should abstain from the preceding command and rather delete unwanted volumes one at a time by using this command:


```bash
$ docker volume rm <volume-name>
```

I should also mention that there is a command to prune Docker networks. But since we have not yet officially introduced networks, I will defer this to chapter 10, Single-Host Networking.

# Formatting the output of common Docker commands
Have you at times wished that your Terminal window was infinitely wide since the output of a Docker command such as docker container ps is scrambled across several lines per item? Worry not, as you can customize the output to your liking. Almost all commands that produce an output have a --format argument, which accepts a so-called Go template as a parameter.

 If you wonder why a Go template, it's because most of Docker is written in this popular low-level language. Let's look at an example. Assume we want to only show the name of the container, the name of the image, and the state of the container, separated by tabs, output by the docker container ps command. The format would then look like this:



```bash
docker container ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
```

**Please be aware that the format string is case sensitive**. Also, note the addition of the -a parameter to include stopped containers in the output. A sample output could look like this:

```bash
NAMES              IMAGE            STATUS
elated_haslett     alpine           Up 2 seconds
brave_chebyshev    hello-world      Exited (0) 3 minutes ago
```

This is definitely nicer to display even on a narrow Terminal window than the unformatted one scattering wildly over multiple lines.

# Filtering the output of common Docker commands
Similar to what we have done in the previous section by pretty-printing the output of Docker commands, we can also filter what is output. There are quite a few filters that are supported. Please find the full list for each command in the Docker online documentation. The format of filters is straightforward and of the type **--filter <key>=<value>**. If we need to combine more than one filter, we can just combine multiple of these statements. Let's do an example with the docker image ls command as I have a lot of images on my workstation:

```bash
 docker image ls --filter dangling=false --filter "reference=docker*:latest"
 docker image ls --filter dangling=false --filter "reference=*:latest"
 docker image ls --filter dangling=false --filter "reference=fredysa/*:*"

```

The preceding filter only outputs images that are not dangling, that is, real images whose fully qualified name is of the form <registry>/<user|org><repository>:<tag>, and the tag is equal to latest. The output on my machine looks like this:


```bash
REPOSITORY                                  TAG     IMAGE ID      CREATED   SIZE
docker.bintray.io/jfrog/artifactory-cpp-ce  latest  092f11699785  9 months  ago 900MB
docker.bintray.io/jfrog/artifactory-oss     latest  a8a8901c0230  9 months  ago 897MB
```

Having shown how to pretty print and filter output generated by the Docker CLI, it is now time to talk once more about building Docker images and how to optimize this process.