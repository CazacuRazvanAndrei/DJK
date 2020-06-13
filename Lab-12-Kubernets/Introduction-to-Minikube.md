# Introduction to MiniKube

Minikube is a tool that creates a single-node Kubernetes cluster in VirtualBox or Hyper-V (other hypervisors are supported too) ready to be used during the development of a containerized application.

As stated there, Minikube is a single-node Kubernetes cluster and thus the node is, at the same time, a Kubernetes master as well as a worker node.


# Installing Minikube

If you cannot use Docker for Desktop or, for some reason, you only have access to an older version of the tool that does not yet support Kubernetes, then it is a good idea to install Minikube. Minikube provisions a single-node Kubernetes cluster on your workstation and is accessible through kubectl, which is the command-line tool used to work with Kubernetes.

# Installing Minikube on macOS and Windows
To install Minikube for macOS or Windows, navigate to the following link: https://kubernetes.io/docs/tasks/tools/install-minikube/.

Follow the instructions carefully. If you have Docker Toolbox installed, then you already have a hypervisor on your system since the Docker Toolbox installer also installed VirtualBox. Otherwise, I recommend that you install VirtualBox first.

If you have Docker for macOS or Windows installed, then you already have kubectl installed with it, so you can skip that step too. Otherwise, follow the instructions on the site.

# Testing Minikube and kubectl

Once Minikube is successfully installed on your workstation, open a Terminal and test the installation. First, we need to start Minikube. Enter minikube start at the command line. This command may take a few minutes or so to complete. The output should look similar to the following:



Let's make sure that Minikube is running with the following command:

```
 minikube start
```
Once Minikube is ready, we can access its single node cluster using kubectl. We should see something similar to the following:

![m12](./img/m12-k4.png)

Listing all nodes in Minikube
As we mentioned previously, we have a single-node cluster with a node called minikube. The...