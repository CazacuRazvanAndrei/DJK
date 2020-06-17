# Minecraft Server
docker pull itzg/minecraft-server

## Run


docker run -d -it -e EULA=TRUE -p 25575:25575 --name mc itzg/minecraft-server

docker run -d -e EULA=TRUE -p 25575:25575 --name mc itzg/minecraft-server
