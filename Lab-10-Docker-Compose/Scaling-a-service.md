# Scaling a service

Now, let's, for a moment, assume that our sample application has been live on the web and become very successful. Loads of people want to see our cute animal images. So now we're facing a problem, since our application has started to slow down. To counteract this problem, we want to run multiple instances of the web service. With Docker Compose, this is readily done.

Running more instances is also called scaling up. We can use this tool to scale our web service up to, say, three instances:

```
docker-compose up --scale web=3
```
If we do this, we are in for a surprise. The output will look similar to the following screenshot:

```
Starting docker-compose_db_1 ...
Starting docker-compose_db_1    ... done
Recreating docker-compose_web_1 ...
Recreating docker-compose_web_1 ... error
Recreating docker-compose_web_3 ...
WARNING: Host is already in use by another container
Recreating docker-compose_web_3 ... error

ERROR: for docker-compose_web_1  Cannot start service web: driver failed programming external connectivity on endpoint docker-compose_web_1 (97f6a390c825312f8f1b7813f7128624efd570fbbcb329210e97d5eb3840bce0): Bind for 0.0.0.0:3000 failed: port is already allocated

ERROR: for docker-compose_web_3  Cannot start service web: driver failed programming external connectivity on endpoint docker-compose_web_3 (72b61af482fd64536f398514c1cbf5e9032aaebeedee48b2ec9c5f006f49770f): Bind for 0.0.0.0:3000 failed: port is already allocated

ERROR: for web  Cannot start service web: driver failed programming external connectivity on endpoint docker-compose_web_1 (97f6a390c825312f8f1b7813f7128624efd570fbbcb329210e97d5eb3840bce0): Bind for 0.0.0.0:3000 failed: port is already allocated
ERROR: Encountered errors while bringing up the project.
```

Output of docker-compose --scale
The second and third instances of the web service fail to start. The error message tells us why: we cannot use the same host port **80** more than once. When instances 2 and 3 try to start, Docker realizes that port **80** is already taken by the first instance. What can we do? Well, we can just let Docker decide which host port to use for each instance.

If, in the **ports** section of the **compose**file, we only specify the container port and leave out the host port, then Docker automatically selects an ephemeral port. Let's do exactly this:

- First, let's tear down the application:

```
$ docker-compose down
```
- Then, we modify the docker-compose.yml file to look as follows:

```
version: "2.4"
services:
  web:
    image: fredysa/web:2.0
    build: web
    ports:
      - 3000
  db:
    image: fredysa/db:1.0
    build: db
    volumes:
      - pets-data:/var/lib/postgresql/data

volumes:
  pets-data:
```
Sample in `docker-compose_scale.yml`

- Now, we can start the application again and scale it up immediately after that: 

```

$  docker-compose up -d --scale web=3
Starting docker-compose_web_1 ... done
Starting docker-compose_web_2 ... done
Starting docker-compose_web_3 ... done
Starting docker-compose_db_1  ... done
```
- If we now do **docker-compose ps**, we should see the following screenshot:

![ams](./img/l10_ams8.png)

Output of docker-compose ps

- As we can see, each service has been associated to a different host port. We can try to see whether they work, for example, using curl. Let's test the third instance, docker-compose_web_3:


```
PS>
start http://localhost:32768/pet
start http://localhost:32769/pet
start http://localhost:32770/pet
```

Pets Demo Application
The answer, Pets Demo Application, tells us that, indeed, our application is still working as expected. Try it out for the other two instances to be sure.

