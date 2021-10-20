# Volume 


```
VOLUME /app/data 
VOLUME /app/data, /app/profiles, /app/config 
VOLUME ["/app/data", "/app/profiles", "/app/config"]
```

The first line in the preceding snippet defines a single volume to be mounted at /app/data. The second line defines three volumes as a comma-separated list. The last one defines the same as the second line, but this time, the value is formatted as a JSON array.

docker image pull mongo:3.7

### **Inspect Image Volume**
```dockerfile
docker image inspect --format='{{json .ContainerConfig.Volumes}}'  mongo:3.7 | jq .
```

### **Start Mongo DB**
```
docker run --name my-mongo -d mongo:3.7
```

### **See the volume**
```
docker inspect --format '{{json .Mounts}}' my-mongo | jq .``
```

### Export config file / Run inside Mchine
export




## **Export config file**

```bash
docker container run --rm -it alpine /bin/sh
/ # export
```
### Pass some information in container --env
```dockerfile
docker container run --rm -it --env LOG_DIR=/var/log/my-log   alpine /bin/sh
/ #
```
### Pass multiple -env

```bash
docker container run --rm -it --env LOG_DIR=/var/log/my-log --env MAX_LOG_FILES=5 --env MAX_LOG_SIZE=1G  alpine /bin/sh
export | grep LOG
```


### Run from env-file
docker container run --rm -it --env-file ./development.config  alpine sh -c "export"


# Defining environment variables in container images
#### dockerfile is in env-file

## Build image
```bash
docker image build -t my-alpine .

docker container run --rm -it  my-alpine sh -c "export | grep LOG"

docker container run --rm -it --env MAX_LOG_SIZE=2G --env MAX_LOG_FILES=10 my-alpine sh -c "export | grep LOG"
```

# Environment variables at build time
```powershell
docker image build `
    --build-arg BASE_IMAGE_VERSION=12.7-alpine `
    -t my-node-app-test .
```



