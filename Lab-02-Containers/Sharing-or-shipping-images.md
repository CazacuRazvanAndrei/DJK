# **Sharing or shipping images**
To be able to ship our custom image to other environments, we need to first give it a globally unique name. This action is often called tagging an image. We then need to publish the image to a central location from which other interested or entitled parties can pull it. These central locations are called image registries.

# Tagging an image
Each image has a so-called tag. A tag is often used to version images, but it has a broader reach than just being a version number. If we do not explicitly specify a tag when working with images, then Docker automatically assumes we're referring to the latest tag. This is relevant when pulling an image from Docker Hub, as in the following example:

```
$ docker image pull alpine
```
The preceding command will pull the alpine:latest image from Docker Hub. If we want to explicitly specify a tag, we do so like this:

```
$ docker image pull alpine:3.5
```
This will now pull the alpine image that has been tagged with 3.5.

# Image namespaces
So far, we have been pulling various images and haven't been worrying so much about where those images originated from. Your Docker environment is configured so that, by default, all images are pulled from Docker Hub. We also only pulled so-called official images from Docker Hub, such as **alpine** or **busybox**.

Now, it is time to widen our horizon a bit and learn about how images are namespaced. The most generic way to define an image is by its fully qualified name, which looks as follows:

```
<registry URL>/<User or Org>/<name>:<tag>
```
Let's look at this in a bit more detail:

`<registry URL>`: This is the URL to the registry from which we want to pull the image. By default, this is docker.io. More generally, this could be https://registry.acme.com.

- Other than Docker Hub, there are quite a few public registries out there that you could pull images from. The following is a list of some of them, in no particular order:

- Google, at https://cloud.google.com/container-registry
- Amazon AWS Amazon Elastic Container Registry (ECR), at https://aws.amazon.com/ecr/
- Microsoft Azure, at https://azure.microsoft.com/en-us/services/container-registry/
- Red Hat, at https://access.redhat.com/containers/
- Artifactory, at https://jfrog.com/integration/artifactory-docker-registry/



- `<User or Org>`: This is the private Docker ID of either an individual or an organization defined on Docker Hub—or any other registry, for that matter—such as microsoft or oracle.
- `<name>`: This is the name of the image, which is often also called a repository.
- `<tag>`: This is the tag of the image.

Let's look at an example, as follows:

```
https://registry.acme.com/engineering/web-app:1.0
```

Here, we have an image, **web-app**, that is tagged with version 1.0 and belongs to the **engineering** organization on the private registry at https://registry.acme.com.

Now, there are some special conventions:

- If we omit the registry URL, then Docker Hub is automatically taken.
- If we omit the tag, then **latest** is taken.
- If it is an official image on Docker Hub, then no user or organization namespace is needed.

Here are a few samples in tabular form:

![SSI](./img/l2-ssi-p1.png)

Now that we know how the fully qualified name of a Docker image is defined and what its parts are, let's talk about some special images we can find on Docker Hub.

# Official images
In the preceding table, we mentioned official image a few times. This needs an explanation. Images are stored in repositories on the Docker Hub registry. Official repositories are a set of repositories hosted on Docker Hub that are curated by individuals or organizations that are also responsible for the software packaged inside the image. Let's look at an example of what that means. There is an official organization behind the Ubuntu Linux distro. This team also provides official versions of Docker images that contain their Ubuntu distros.

Official images are meant to provide essential base OS repositories, images for popular programming language runtimes, frequently used data storage, and other important services.

Docker sponsors a team whose task it is to review and publish all those curated images in public repositories on Docker Hub. Furthermore, Docker scans all official images for vulnerabilities.

# Pushing images to a registry
Creating custom images is all well and good, but at some point, we want to actually share or ship our images to a target environment, such as a test, quality assurance (QA), or production system. For this, we typically use a container registry. One of the most popular and public registries out there is Docker Hub. It is configured as a default registry in your Docker environment, and it is the registry from which we have pulled all our images so far.

On a registry, one can usually create personal or organizational accounts. For example, my personal account at Docker Hub is **fredysa**. Personal accounts are good for personal use. If we want to use the registry professionally, then we'll probably want to create an organizational account, such as **acme,** on Docker Hub. The advantage of the latter is that organizations can have **multiple teams**. Teams can have differing permissions.

To be able to push an image to my personal account on Docker Hub, I need to tag it accordingly:

- Let's say I want to push the latest version of Alpine to my account and give it a tag of 1.0. I can do this in the following way:
```
$ docker image tag alpine:latest fredysa/alpine:1.0
```
Now, to be able to push the image, I have to log in to my account, as follows:
```
$ docker login -u fredysa -p <my secret password>
```
After a successful login, I can then push the image, like this:
```
$ docker image push fredysa/alpine:1.0
```
I will see something similar to this in the Terminal:

```
The push refers to repository [docker.io/fredysa/alpine]
04a094fe844e: Mounted from library/alpine
1.0: digest: sha256:5cb04fce... size: 528
```

For each image that we push to Docker Hub, we automatically create a repository. A repository can be private or public. Everyone can pull an image from a public repository. From a private repository, an image can only be pulled if one is logged in to the registry and has the necessary permissions configured.