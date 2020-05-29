# Data Volumes and Configuration


#Create Volume
docker volume create sample2

# Inspect Volume
 docker volume inspect sample

# Create container with sample

docker container run --name test -it -v sample:/data  alpine /bin/sh

/ # cd /data / # echo "Some data" > data.txt 
/ # echo "Some more data" > data2.txt 
/ # exit

# See what is new 
docker container diff test

docker volume ls

# Add stuff
docker container run --rm -it -v sample:/data alpine /bin/sh

echo "Hello world" > /data/sample.txt
echo "Other message" > /data/other.txt

# See data from volume
# Windows Version
#Run privileged 
docker run -it --rm --privileged --pid=host  fundamentalsofdocker/nsenter

# Run in container
cd /var/lib/docker/volumes/sample/_data
ls -l 
echo "I love Docker" > docker.txt
ls -l 


## Scenario2
# Read write in 1 container
# read in the rest to keep consistency


docker container run -it --name writer -v shared-data:/data alpine /bin/sh
# Here, we create a container called writer that has a volume, shared-data, mounted in default read/write mode:


# / echo "I can create a file" > /data/sample.txt 


# Exit this container, and then execute the following command: Ctrl-D
 docker container run -it --name reader -v shared-data:/app/data:ro ubuntu:19.04 /bin/bash


 ls -l /app/data 

#Try write something 
echo "Try to break read/only" > /app/data/data.txt

# It will fail with the following message: bash: /app/data/data.txt: Read-only file system
exit

docker container ls -a
docker volume ls -q

docker container rm -f $(docker container ls -aq) 
docker volume rm $(docker volume ls -q) 
