# **Defining volumes in images**
If we go for a moment back to what we have learned about containers in Chapter 3, Mastering Containers, then we have this: the filesystem of each container, when started, is made up of the immutable layers of the underlying image, plus a writable container layer specific to this very container. All changes that the processes running inside the container make to the filesystem will be persisted in this container layer. Once the container is stopped and removed from the system, the corresponding container layer is deleted from the system and irreversibly lost.

Some applications, such as databases running in containers, need to persist their data beyond the lifetime of the container. In this case, they can use volumes. To make things a bit more explicit, let's look at a concrete example. MongoDB is a popular open source document database. Many developers use MongoDB as a storage service for their applications. The maintainers of MongoDB have created an image and published it on Docker Hub, which can be used to run an instance of the database in a container. This database will be producing data that needs to be persisted long term, but the MongoDB maintainers do not know who uses this image and how it is used. So, they have no influence over the **docker container run** command with which the users of the database will start this container. *How can they now define volumes?*

Luckily, there is a way of defining volumes in the Dockerfile. The keyword to do so is VOLUME, and we can either add the absolute path to a single folder or a comma-separated list of paths. These paths represent folders of the container's filesystem. Let's look at a few samples of such volume definitions, as follows:

```
VOLUME /app/data 
VOLUME /app/data, /app/profiles, /app/config 
VOLUME ["/app/data", "/app/profiles", "/app/config"] 
```

The first line in the preceding snippet defines a single volume to be mounted at **/app/data**. The second line defines three volumes as a comma-separated list. The last one defines the same as the second line, but this time, the value is formatted as a JSON array.

When a container is started, Docker automatically creates a volume and mounts it to the corresponding target folder of the container for each path defined in the **Dockerfile**. Since each volume is created automatically by Docker, it will have an SHA-256 as its ID.

At container runtime, the folders defined as volumes in the Dockerfile are excluded from the Union filesystem, and thus any changes in those folders do not change the container layer but are persisted to the respective volume. It is now the responsibility of the operations engineers to make sure that the backing storage of the volumes is properly backed up.

We can use the **docker image inspect** command to get information about the volumes defined in the **Dockerfile**. Let's see what MongoDB gives us by following these steps:

First, we pull the image with the following command:
```
$ docker image pull mongo:3.7
```

Then, we inspect this image, and use the **--format** parameter to only extract the essential part from the massive amount of data, as follows:
```
 $ docker image inspect \
    --format='{{json .ContainerConfig.Volumes}}' \
    mongo:3.7 | jq .
```

- **Note** the | jq . at the end of the command. We are piping the output of docker image inspect into the jq tool, which nicely formats the output. If you haven't installed jq yet on your system, you can do so with brew install jq on your macOS, or with choco install jq on Windows.


The preceding command will return the following result:

```
{
    "/data/configdb": {},
    "/data/db": {}
}
```

Evidently, the **Dockerfile** for **MongoDB** defines two volumes at **/data/configdb** and **/data/db**.

Now, let's run an instance of MongoDB in the background as a daemon, as follows:

```
$ docker run --name my-mongo -d mongo:3.7
```

We can now use the **docker container inspect** command to get information about the volumes that have been created, among other things.

Use this command to just get the volume information:

```
$ docker inspect --format '{{json .Mounts}}' my-mongo | jq .
```

The preceding command should output something like this (shortened):

```
[
  {
    "Type": "volume",
    "Name": "b9ea0158b5...",
    "Source": "/var/lib/docker/volumes/b9ea0158b.../_data",
    "Destination": "/data/configdb",
    "Driver": "local",
    ...
  },
  {
    "Type": "volume",
    "Name": "5becf84b1e...",
    "Source": "/var/lib/docker/volumes/5becf84b1.../_data",
    "Destination": "/data/db",
    ...
  }
]
```

Note that the values of the **Name** and **Source** fields have been trimmed for readability. The **Source** field gives us the path to the host directory, where the data produced by the MongoDB inside the container will be stored.

That's it for the moment about volumes. In the next section, we will explore how we can configure applications running in containers, and the container image build process itself.