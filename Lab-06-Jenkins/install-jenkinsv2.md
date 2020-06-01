https://tutorials.releaseworksacademy.com/learn/the-simple-way-to-run-docker-in-docker-for-ci


docker run --rm -d `
   --name jenkins `
   -u root `
   -p 8080:8080 `
   -v jenkins:/var/jenkins_home `
   -v /var/run/docker.sock:/var/run/docker.sock `
   -v $Pwd/:/home `
   jenkins/jenkins:lts

docker run -p 8080:8080 `
  -v /var/run/docker.sock:/var/run/docker.sock `
  -v $Pwd/:/home `
  --name jenkins `
  jenkins/jenkins:lts

docker exec -it -u root jenkins bash

apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce


docker version
docker ps

