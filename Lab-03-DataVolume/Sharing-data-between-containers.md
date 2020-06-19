# **Sharing data between containers**
Containers are like sandboxes for the applications running inside them. This is mostly beneficial and wanted, in order to protect applications running in different containers from each other. It also means that the whole filesystem visible to an application running inside a container is private to this application, and no other application running in a different container can interfere with it.

At times, though, we want to share data between containers. Say an application running in container A produces some data that will be consumed by another application running in container B. How can we achieve this? Well, I'm sure you've already guessed it—we can use Docker volumes for this purpose. We can create a volume and mount it to container A, as well as to container B. In this way, both applications A and B have access to the same data.

Now, as always when multiple applications or processes concurrently access data, we have to be very careful to avoid inconsistencies. To avoid concurrency problems such as race conditions, we ideally have only one application or process that is creating or modifying data, while all other processes concurrently accessing this data only read it. We can enforce a process running in a container to only be able to read the data in a volume by mounting this volume as read-only. Have a look at the following command:

```
$ docker container run -it --name writer \
    -v shared-data:/data \
    alpine /bin/sh
```

Here, we create a container called writer that has a volume, shared-data, mounted in default read/write mode:

Try to create a file inside this container, like this:

```
# / echo "I can create a file" > /data/sample.txt 
```
It should succeed.

Exit this container, and then execute the following command:
```
$ docker container run -it --name reader \
    -v shared-data:/app/data:ro \
    ubuntu:19.04 /bin/bash
```

And we have a container called reader that has the same volume mounted as read-only (ro).

Firstly, make sure you can see the file created in the first container, like this:
```
$ ls -l /app/data 
total 4
-rw-r--r-- 1 root root 20 Jan 28 22:55 sample.txt
```

Then, try to create a file, like this:

```
# / echo "Try to break read/only" > /app/data/data.txt
```

It will fail with the following message:

```
bash: /app/data/data.txt: Read-only file system
```

Let's exit the container by typing exit at the Command Prompt. Back on the host, let's clean up all containers and volumes, as follows:

```
$ docker container rm -f $(docker container ls -aq) 
$ docker volume rm $(docker volume ls -q) 
```

Once this is done, exit the docker-machine VM by also typing exit at the Command Prompt. You should be back on your Docker for Desktop. Use docker-machine to stop the VM, like this:
```
$ docker-machine stop node-1 
```
Next, we will show how to mount arbitrary folders from the Docker host into a container.

