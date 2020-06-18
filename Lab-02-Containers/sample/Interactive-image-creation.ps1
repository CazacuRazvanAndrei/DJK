# Interactive image creation

docker container run -it --name sample  alpine:3.10 /bin/sh

#Inside :

apk update && apk add iputils
#Install ping

ping 127.0.0.1
exit

# Isolate sample Bash
docker container ls -a | grep sample

# Isolate sample PS
docker container ls -a | ? {$_ -like "*sample*"}

## See what is diferent from the basic
docker container diff sample 

<#
A stands for added
C stands for changed.
#>

#Create a new Image from one existing and modified
docker container commit sample my-alpine
docker container ls 
docker image ls

docker image history my-alpine
# See change 