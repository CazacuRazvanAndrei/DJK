# Docker CE
Part of the Docker Community Edition are products such as the Docker Toolbox and Docker for Desktop with its editions for Mac and Windows. All these products are mainly targeted at developers.

Docker for Desktop is an easy-to-install desktop application that can be used to build, debug, and test Dockerized applications or services on a macOS or Windows machine. Docker for macOS and Docker for Windows are complete development environments that are deeply integrated with their respective hypervisor framework, network, and filesystem. These tools are the fastest and most reliable way to run Docker on a Mac or Windows.

Under the CE umbrella, there are also two products that are more geared toward operations engineers. These products are Docker for Azure and Docker for AWS.

For example, with Docker for Azure, which is a native Azure application, you can set up Docker in a few clicks, optimized for and integrated with underlying Azure Infrastructure as a Service (IaaS) services. It helps operations engineers accelerate time to productivity when building and running Docker applications in Azure.

Docker for AWS works very similarly but for Amazon's cloud.

# Docker EE
The Docker Enterprise Edition consists of the **Universal Control Plane (UCP)** and the **Docker Trusted Registry (DTR)**, both of which run on top of Docker Swarm. Both are swarm applications. Docker EE builds on top of the upstream components of the Moby project and adds enterprise-grade features such as **role-based access control (RBAC)**, multi-tenancy, mixed clusters of Docker swarm and Kubernetes, web-based UI, and content trust, as well as image scanning on top.