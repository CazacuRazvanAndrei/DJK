# Run Hello-World Alpine
docker container run alpine echo "Hello World"

# Run Again
docker container run alpine echo "Hello World" 

#Try Diferent
docker container run centos ping -c 5 127.0.0.1


# Run in CMD
## Install Jq for Json

choco install jq -y
choco install wget -y
 
wget -qO- http://jservice.io/api/random | jq .[0].question 

# Powershell
while ($true) {
    
$uri = "http://jservice.io/api/random"
$game = Invoke-RestMethod -Uri $uri
$game.question
"----------------------------------------------"
Write-Host $game.answer -ForegroundColor Green
"______________________________________________"
Start-Sleep -seconds 20

}

# Run Trivia Localy
# List Containers

docker container run -d --name trivia fundamentalsofdocker/trivia:ed2

docker container ls -l
# Show 

docker rm -f trivia
#Remove

docker container ls -a
#This will list containers in any state, such as created, running, or exited

docker container ls --help
# Help

# Start / Stop
docker container run -d --name trivia fundamentalsofdocker/trivia:ed2

docker container start trivia
docker container stop trivia
# Container id can be use also
# -f or --force can be used

# Troubleshot docker
docker container inspect trivia 
docker container inspect -f "{{json .State}}" trivia | jq .

# Connect inside continer
docker container exec -i -t trivia /bin/sh
run : ps
# Run exit to close

# This cmd is similar 
docker container exec trivia ps

#Attach terminal - See continer terminal
docker container attach trivia
# Ctrl-C dettach

#Run another server in paralel  nginx
docker run -d --name nginx -p 8080:80 nginx:alpine

# Instal curl
choco install curl -y
curl -4 localhost:8080

#PS
Start-Process http://localhost:8080

# Attach nginx
docker container attach nginx
# refresh in browser
# Run curl multiple time

# Delete Nginx
docker container stop nginx
docker container rm nginx

docker container ps 


# Logs containers
docker container logs trivia
#all logs

docker container logs --tail 5 trivia
#tail last 5

docker container logs --tail 5 --follow trivia
#follow


#



