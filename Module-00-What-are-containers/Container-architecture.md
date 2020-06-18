Container architecture
Now, let's discuss how a system that can run Docker containers is designed at a high level. The following diagram illustrates what a computer that Docker has been installed on looks like. Note that a computer that has Docker installed on it is often called a Docker host because it can run or host Docker containers:

![wic](./img/m01-d-p1.png)

High-level architecture diagram of the Docker engine
In the preceding diagram, we can see three essential parts:

- On the bottom, we have the Linux operating system
- In the middle, in dark gray, we have the container runtime
- On the top, we have the Docker engine


Containers are only possible due to the fact that the Linux OS provides some primitives, such as namespaces, control groups, layer capabilities, and more, all of which are leveraged in a very specific way by the container runtime and the Docker engine. Linux kernel namespaces, such as **process ID (pid)** namespaces or **network (net)**namespaces, allow Docker to encapsulate or sandbox processes that run inside the container. **Control Groups**make sure that containers cannot suffer from the noisy-neighbor syndrome, where a single application running in a container can consume most or all of the available resources of the whole Docker host. **Control Groups** allow Docker to limit the resources, such as CPU time or the amount of RAM, that each container is allocated.

The container runtime on a Docker host consists of **containerd**and **runc**. **runc**is the low-level functionality of the **container** runtime, while containerd, which is based on **runc**, provides higher-level functionality. Both are open source and have been donated by Docker to the CNCF.

The container runtime is responsible for the whole life cycle of a container. It pulls a container image (which is the template for a container) from a registry if necessary, creates a container from that image, initializes and runs the container, and eventually stops and removes the container from the system when asked.

The **Docker engine** provides additional functionality on top of the container runtime, such as network libraries or support for plugins. It also provides a REST interface over which all container operations can be automated. The Docker command-line interface that we will use frequently in this book is one of the consumers of this REST interface.