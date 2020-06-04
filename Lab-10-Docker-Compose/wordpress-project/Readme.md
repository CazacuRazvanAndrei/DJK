# Wordpress 

# Create local build

```
cd ~\wordpress-project\database
docker image build -t fredysa/wp-db:1.0 .

cd ~\wordpress-project\wordpress\
docker image build -t fredysa/wordpress:1.0 .

docker image ls
```
# Run docker-compose

```
docker-compose build
docker-compose up -d

docker-compose ps

```
