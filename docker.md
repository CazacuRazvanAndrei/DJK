# [What Are Containers and Why Should I Use Them?](docker_M1.md)

This first chapter will introduce you to the world of containers and their orchestration. This book starts from the very beginning, in that it assumes that you have no prior knowledge of containers, and will give you a very practical introduction to the topic.

In this chapter, we will focus on the software supply chain and the friction within it. Then, we'll present containers, which are used to reduce this friction and add enterprise-grade security on top of it. We'll also look into how containers and the ecosystem around them are assembled. We'll specifically point out the distinction between the upstream Open Source Software (OSS) components, united under the code name Moby, that form the building blocks of the downstream products of Docker and other vendors.

Originally, when Docker (the company) introduced Docker containers, everything was open source. Docker didn't have any commercial products at this time. The Docker engine that the company developed was a monolithic piece of software. It contained many logical parts, such as the container runtime, a network library, a RESTful (REST) API, a command-line interface, and much more.


## Docker Version 

Docker currently separates its product lines into two segments. There is the **Community Edition (CE)**, which is closed-source yet completely free, and then there is the **Enterprise Edition (EE)**, which is also closed-source and needs to be licensed on a yearly basis. These enterprise products are backed by 24/7 support and are supported by bug fixes.

- [Docker CE](Docker_CE.md)
- [Docker EE](Docker_EE.md)


## Links 

- Docker overview: https://docs.docker.com/engine/docker-overview/
- The Moby project: https://mobyproject.org/
- Docker products: https://www.docker.com/get-started
- Cloud-Native Computing Foundation: https://www.cncf.io/ (Free Trainings)
- containerd – an industry-standard container runtime: https://containerd.io/


# Setting Up a Working Environment

In this chapter, we are going to prepare our personal or working environment to work efficiently and effectively with Docker. We will discuss in detail how to set up an ideal environment for developers, DevOps, and operators that can be used when working with Docker containers.

For this chapter, you will need a laptop or a workstation with either macOS or Windows, preferably Windows 10 Professional, installed. You should also have free internet access to download applications and permission to install those applications on your laptop.

It is also possible to follow along with this book if you have a Linux distribution as your operating system, such as Ubuntu 18.04 or newer. I will try to indicate where commands and samples differ significantly from the ones on macOS or Windows.



- The Linux command shell
- PowerShell for Windows
- Installing and using a package manager
- Installing Git and cloning the code repository
- Choosing and installing a code editor
- Installing Docker for Desktop on macOS or Windows
- Installing Docker Toolbox
- Installing Minikube

## Links 
- Linux Command Line Cheat Sheet by Dave Child at http://bit.ly/2mTQr8l
- PowerShell Basic Cheat Sheet at http://bit.ly/2EPHxze
