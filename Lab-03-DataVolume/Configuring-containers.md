# **Configuring containers**
More often than not, we need to provide some configuration to the application running inside a container. The configuration is often used to allow one and the same container to run in very different environments, such as in development, test, staging, or production environments. 

In Linux, configuration values are often provided via environment variables. 

We have learned that an application running inside a container is completely shielded from its host environment. Thus, the environment variables that we see on the host are different from the ones that we see from within a container.

Let's prove that by first looking at what is defined on our host:

Use this command:
```
wsl 
$ export
```
On my macOS,Linux wsl we see something like this (shortened):

```
...
COLORFGBG '7;0'
COLORTERM truecolor
HOME /Users/...
ITERM_PROFILE Default
ITERM_SESSION_ID w0t1p0:47EFAEFE-BA29-4CC0-B2E7-8C5C2EA619A8
LC_CTYPE UTF-8
LOGNAME ...
...
```
Next, let's run a shell inside an alpine container, and list the environment variables we see there, as follows:
```
$ docker container run --rm -it alpine /bin/sh
/ # export

export HOME='/root'
export HOSTNAME='91250b722bc3'
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
export PWD='/'
export SHLVL='1'
export TERM='xterm'
```

The preceding output we see from the **export** command is evidently totally different than what we saw directly on the host.

Hit Ctrl + D to leave the alpine container.

Next, let's define environment variables for containers. 

# Defining environment variables for containers

Now, the good thing is that we can actually pass some configuration values into the container at start time. We can use the **--env**(or the short form, -e) parameter in the form **`--env <key>=<value>`** to do so, where **`<key>`** is the name of the environment variable and **<value>** represents the value to be associated with that variable. Let's assume we want the app that is to be run in our container to have access to an environment variable called LOG_DIR, with the value **/var/log/my-log**. We can do so with this command:

```
$ docker container run --rm -it \
    --env LOG_DIR=/var/log/my-log \
    alpine /bin/sh
/ #
```

The preceding code starts a shell in an **alpine** container and defines the requested environment inside the running container. To prove that this is true, we can execute this command inside the alpine container:

```
/ # export | grep LOG_DIR

export LOG_DIR='/var/log/my-log'
```
The output looks as expected. We now indeed have the requested environment variable with the correct value available inside the container.

We can, of course, define more than just one environment variable when we run a container. We just need to repeat the --env (or -e) parameter. Have a look at this sample:

```
$ docker container run --rm -it \
    --env LOG_DIR=/var/log/my-log \
    --env MAX_LOG_FILES=5 \
    --env MAX_LOG_SIZE=1G \
 alpine /bin/sh
/ #
```

If we do a list of the environment variables now, we see the following:

```
/ # export | grep LOG

export LOG_DIR='/var/log/my-log'
export MAX_LOG_FILES='5'
export MAX_LOG_SIZE='1G'
```

Let's now look at situations where we have many environment variables to configure.

# Using configuration files
Complex applications can have many environment variables to configure, and thus our command to run the corresponding container can quickly become unwieldy. For this purpose, Docker allows us to pass a collection of environment variable definitions as a file, and we have the **--env-file** parameter in the **docker container run** command. 

Let's try this out, as follows:

Create a fod/05 folder and navigate to it, like this:

```
$ cd ~\DJK\Lab-03-DataVolume\sample\env-file
```

Use your favorite editor to create a file called **development.config** in this folder. Add the following content to the file, and save it, as follows:
```
LOG_DIR=/var/log/my-log
MAX_LOG_FILES=5
MAX_LOG_SIZE=1G
```
Notice how we have the definition of a single environment variable per line in the format **`<key>=<value>`**, where, once again, **`<key>`** is the name of the environment variable, and **`<value>`** represents the value to be associated with that variable.

Now, from within the fod/05 folder, let's run an alpine container, pass the file as an environment file, and run the export command inside the container to verify that the variables listed inside the file have indeed been created as environment variables inside the container, like this:

```
$ docker container run --rm -it \
    --env-file ./development.config \
    alpine sh -c "export"
```

And indeed, the variables are defined, as we can see in the output generated:

```
export HOME='/root'
export HOSTNAME='30ad92415f87'
export LOG_DIR='/var/log/my-log'
export MAX_LOG_FILES='5'
export MAX_LOG_SIZE='1G'
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
export PWD='/'
export SHLVL='1'
export TERM='xterm'
```

Next, let's look at how to define default values for environment variables that are valid for all container instances of a given Docker image.

# Defining environment variables in container images
Sometimes, we want to define some default value for an environment variable that must be present in each container instance of a given container image. We can do so in the **Dockerfile** that is used to create that image by following these steps:

Use your favorite editor to create a file called Dockerfile in the ~~\DJK\Lab-03-DataVolume\sample\env-file. Add the following content to the file, and save it:
```
FROM alpine:latest
ENV LOG_DIR=/var/log/my-log
ENV  MAX_LOG_FILES=5
ENV MAX_LOG_SIZE=1G
```
Create a container image called my-alpine using the preceding Dockerfile, as follows:
```
$ docker image build -t my-alpine .
```

Run a container instance from this image that outputs the environment variables defined inside the container, like this:

```
$ docker container run --rm -it \
    my-alpine sh -c "export | grep LOG"

export LOG_DIR='/var/log/my-log'
export MAX_LOG_FILES='5'
export MAX_LOG_SIZE='1G'
```

This is exactly what we would have expected. 

The good thing, though, is that we are not stuck with those variable values at all. We can override one or many of them, using the **--env** parameter in the **docker container run** command. Have a look at the following command and its output:

```
$ docker container run --rm -it \
    --env MAX_LOG_SIZE=2G \
    --env MAX_LOG_FILES=10 \
    my-alpine sh -c "export | grep LOG"

export LOG_DIR='/var/log/my-log'
export MAX_LOG_FILES='10'
export MAX_LOG_SIZE='2G'
```

We can also override default values, using environment files together with the --env-file parameter in the docker container run command. Please try it out for yourself.

# Environment variables at build time
Sometimes, we would want to have the possibility to define some environment variables that are valid at the time when we build a container image. Imagine that you want to define a BASE_IMAGE_VERSION environment variable that shall then be used as a parameter in your Dockerfile. Imagine the following Dockerfile:

```
ARG BASE_IMAGE_VERSION=12.7-stretch
FROM node:${BASE_IMAGE_VERSION}
WORKDIR /app
COPY packages.json .
RUN npm install
COPY . .
CMD npm start
```

We are using the **ARG** keyword to define a default value that is used each time we build an image from the preceding Dockerfile. In this case, that means that our image uses the node:12.7-stretch base image.

Now, if we want to create a special image for—say—testing purposes, we can override this variable at image build time using the --build-arg parameter, as follows:

```
$ docker image build \
    --build-arg BASE_IMAGE_VERSION=12.7-alpine \
    -t my-node-app-test .
```

In this case, the resulting **my-node-test:latest** image will be built from the node:12.7-alpine base image and not from the **node:12.7-stretch** default image.

To summarize, environment variables defined via **--env** or **--env-file** are valid at container runtime. Variables defined with ARG in the **Dockerfile** or **--build-arg** in the **docker container build** command are valid at container image build time. The former are used to configure an application running inside a container, while the latter are used to parametrize the container image build process.