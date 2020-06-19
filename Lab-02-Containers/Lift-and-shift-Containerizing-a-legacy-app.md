# **Lift and shift: Containerizing a legacy app**
We can't always start from scratch and develop a brand new application. More often than not, we find ourselves with a huge portfolio of traditional applications that are up and running in production and provide mission-critical value to the company or the customers of the company. Often, those applications are organically grown and very complex. Documentation is sparse, and nobody really wants to touch such an application. Often, the saying Never touch a running system applies. Yet, market needs change, and with that arises the need to update or rewrite those apps. Often, a complete rewrite is not possible due to the lack of resources and time, or due to the excessive cost. What are we going to do about those applications? Could we possibly Dockerize them and profit from benefits introduced by containers?

It turns out we can. In 2017, Docker introduced a program called **Modernize Traditional Apps (MTA)** to their enterprise customers, which in essence promised to help those customers to take their existing or traditional Java and .NET applications and containerize them, without the need to change a single line of code. The focus of MTA was on Java and .NET applications since those made up the lion's share of the traditional applications in a typical enterprise. But the same is possible for any application that was written in—say—C, C++, Python, Node.js, Ruby, PHP, or Go, to just name a few other languages and platforms.

Let's imagine such a legacy application for a moment. Assume we have an old Java application written 10 years ago, and continuously updated during the following 5 years. The application is based on Java SE 6, which came out in December 2006. It uses environment variables and property files for configuration. Secrets such as username and passwords used in the database connection strings are pulled from a secrets keystore, such as HashiCorp's Vault. 

# Analysis of external dependencies
One of the first steps in the modernization process is to discover and list all external dependencies of the legacy application.

We need to ask ourselves questions like the following:

- Does it use a database? If yes, which one? What does the connection string look like?
- Does it use external APIs such as credit card approval or geo-mapping APIs? What are the API keys and key secrets?
- Is it consuming from or publishing to an Enterprise Service Bus (ESB)?


These are just a few possible dependencies that come to mind. Many more exist. These are the seams of the application to the outer world, and we need to be aware of them and create an inventory.

# Source code and build instructions
The next step is to locate all the source code and other assets, such as images and CSS and HTML files that are part of the application. Ideally, they should be located in a single folder. This folder will be the root of our project and can have as many subfolders as needed. This project root folder will be the context during the build of the container image we want to create for our legacy application. Remember, the Docker builder only includes files in the build that are part of that context; in our case, that is the root project folder.

There is, though, an option to download or copy files during the build from different locations, using the **COPY** or **ADD** commands. Please refer to the online documentation for the exact details on how to use these two commands. This option is useful if the sources for your legacy application cannot be easily contained in a single, local folder.

Once we are aware of all the parts that are contributing to the final application, we need to investigate how the application is built and packaged. In our case, this is most probably done by using Maven. Maven is the most popular build automation tool for Java, and has been—and still is—used in most enterprises that are developing Java applications. In the case of a legacy .NET application, it is most probably done by using the MSBuild tool; and in the case of a C/C++ application, Make would most likely be used.

Once again, let's extend our inventory and write down the exact build commands used. We will need this information later on when authoring the **Dockerfile**.

# Configuration
Applications need to be configured. Information provided during configuration can be—for example— the type of application logging to use, connection strings to databases, hostnames to services such as ESBs or URIs to external APIs, to name just a few.

We can differentiate a few types of configurations, as follows:

- **Build time**: This is the information needed during the build of the application and/or its - Docker image. It needs to be available when we create the Docker images.
- **Environment**: This is configuration information that varies with the environment in which the application is running—for example, DEVELOPMENT versus STAGING or PRODUCTION. This kind of configuration is applied to the application when a container with the app starts—for example, in production.
- **Runtime**: This is information that the application retrieves during runtime, such as secrets to access an external API.

# Secrets
Every mission-critical enterprise application needs to deal with secrets in some form or another. The most familiar secrets are part of the connection information needed to access databases that are used to persist the data produced by or used by the application. Other secrets include the credentials needed to access external APIs, such as a credit score lookup API. It is important to note that, here, we are talking about secrets that have to be provided by the application itself to the service providers the application uses or depends on, and not secrets provided by the users of the application. The actor here is our application, which needs to be authenticated and authorized by external authorities and service providers.

There are various ways traditional applications got their secrets. The worst and most insecure way of providing secrets is by hardcoding them or reading them from configuration files or environment variables, where they are available in cleartext. A much better way is to read the secrets during runtime from a special secrets store that persists the secrets encrypted and provides them to the application over a secure connection, such as **Transport Layer Security (TLS)**.

Once again, we need to create an inventory of all secrets that our application uses and the way it procures them. Is it through environment variable or configuration files, or is it by accessing an external keystore, such as HashiCorp's Vault?

# Authoring the Dockerfile
Once we have a complete inventory of all the items discussed in the previous few sections, we are ready to author our Dockerfile. But I want to warn you: don't expect this to be a one-shot-and-go task. You may need several iterations until you have crafted your final Dockerfile. The Dockerfile may be rather long and ugly-looking, but that's not a problem, as long as we get a working Docker image. We can always fine-tune the Dockerfile once we have a working version.

# The base image
Let's start by identifying the base image we want to use and build our image from. Is there an official Java image available that is compatible with our requirements? Remember that our imaginary application is based on Java SE 6. If such a base image is available, then let's use that one. Otherwise, we want to start with a Linux distro such as Red Hat, Oracle, or Ubuntu. In the latter case, we will use the appropriate package manager of the distro (**yum, apt**, or **another**) to install the desired versions of Java and Maven. For this, we use the **RUN** keyword in the **Dockerfile**. Remember, **RUN** gives us the possibility to execute any valid Linux command in the image during the build process.

# Assembling the sources
In this step, we make sure all source files and other artifacts needed to successfully build the application are part of the image. Here, we mainly use the two keywords of the **Dockerfile: COPY** and **ADD**. Initially, the structure of the source inside the image should look exactly the same as on the host, to avoid any build problems. Ideally, you would have a single COPY command that copies all of the root project folder from the host into the image. The corresponding **Dockerfile** snippet could then look as simple as this:

```
WORKDIR /app
COPY . .
```

- **Tip:** Don't forget to also provide a **.dockerignore** file located in the project root folder, which lists all the files and (sub-) folders of the project root folder that should not be part of the build context.
As mentioned earlier, you can also use the **ADD** keyword to download sources and other artifacts into the Docker image that are not located in the build context but somewhere reachable by a URI, as shown here:

```
ADD http://example.com/foobar ./ 
```

This would create a **foobar** folder in the image's working folder and copy all the contents from the URI.

# Building the application
In this step, we make sure to create the final artifacts that make up our executable legacy application. Often, this is a JAR or WAR file, with or without some satellite JARs. This part of the Dockerfile should exactly mimic the way you traditionally used to build an application before containerizing them. Thus, if using Maven as the build automation tool, the corresponding snippet of the Dockerfile could look as simple as this:

```
RUN mvn --clean install
```
In this step, we may also want to list the environment variables the application uses, and provide sensible defaults. But never provide default values for environment variables that provide secrets to the application such as the database connection string! Use the **ENV** keyword to define your variables, like this:

```
ENV foo=bar
ENV baz=123
```

Also, declare all ports that the application is listening on and that need to be accessible from outside of the container via the **EXPOSE** keyword, like this:

```
EXPOSE 5000
EXPOSE 15672/tcp
```

# Defining the start command
Usually, a Java application is started with a command such as java -jar <main application jar> if it is a standalone application. If it is a WAR file, then the start command may look a bit different. We can thus either define the ENTRYPOINT or the CMD to use this command. Thus, the final statement in our Dockerfile could look like this:

```
ENTRYPOINT java -jar pet-shop.war
```

Often, though, this is too simplistic, and we need to execute a few pre-run tasks. In this case, we can craft a script file that contains the series of commands that need to be executed to prepare the environment and run the application. Such a file is often called **docker-entrypoint.sh**, but you are free to name it however you want. Make sure the file is executable— for example, with the following:

```
chmod +x ./docker-entrypoint.sh
```

 The last line of the Dockerfile would then look like this:

```
ENTRYPOINT ./docker-entrypoint.sh
```

Now that you have been given hints on how to containerize a legacy application, it is time to recap and ask ourselves: *Is it really worth the whole effort?*

# Why bother?
At this point, I can see you scratching your head and asking yourself: Why bother? Why should you take on all this seemingly huge effort just to containerize a legacy application? What are the benefits?

It turns out that the **return on investment (ROI)** is huge. Enterprise customers of Docker have publicly disclosed at conferences such as DockerCon 2018 and 2019 that they are seeing these two main benefits of Dockerizing traditional applications:

- More than a 50% saving in maintenance costs.
- Up to a 90% reduction in the time between the deployments of new releases.

The costs saved by reducing the maintenance overhead can be directly reinvested and used to develop new features and products. The time saved during new releases of traditional applications makes a business more agile and able to react to changing customer or market needs more quickly.

Now that we have discussed at length how to build Docker images, it is time to learn how we can ship those images through the various stages of the software delivery pipeline.