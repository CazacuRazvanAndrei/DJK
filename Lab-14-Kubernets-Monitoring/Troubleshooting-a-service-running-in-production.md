# Troubleshooting a service running in production
It is a recommended best practice to create minimal images for production that don't contain anything that is not absolutely needed. This includes common tools that are usually used to debug and troubleshoot an application, such as netcat, iostat, ip, or others. Ideally, a production system only has the container orchestration software such as Kubernetes installed on a cluster node with a minimal OS, such as Core OS. The application container in turn ideally only contains the binaries absolutely necessary to run. This minimizes the attack surface and the risk of having to deal with vulnerabilities. Furthermore, a small image has the advantage of being downloaded quickly, using less space on disk and in memory and showing faster startup times.

But this can be a problem if one of the application services running on our Kubernetes cluster shows unexpected behavior and maybe even crashes. Sometimes we are not able to find the root cause of the problem just from the logs generated and collected, so we might need to troubleshoot the component on the cluster node itself.

We may be tempted to SSH into the given cluster node and run some diagnostic tools. But this is not possible since the cluster node only runs a minimal Linux distro with no such tools installed. As a developer, we could now just ask the cluster administrator to install all the Linux diagnostic tools we intend to use. But that is not a good idea. First of all, this would open the door for potentially vulnerable software now residing on the cluster node, endangering all the other pods that run on that node, and also open a door to the cluster itself that could be exploited by hackers. Furthermore, it is always a bad idea to give developers direct access to nodes of a production cluster, no matter how much you trust your developers. Only a limited number of cluster administrators should ever be able to do so.

A better solution is to have the cluster admin run a so-called bastion container on behalf of the developers. This bastion or troubleshoot container has all the tools installed that we need to pinpoint the root cause of the bug in the application service. It is also possible to run the bastion container in the host's network namespace; thus, it will have full access to all the network traffic of the container host.

# The netshoot container
Nicola Kabar, a former Docker employee, has created a handy Docker image called nicolaka/netshoot that field engineers at Docker use all the time to troubleshoot applications running in production on Kubernetes or Docker Swarm. We created a copy of the image for this book, available at fundamentalsofdocker/netshoot. The purpose of this container in the words of the creator is as follows:

"Purpose: Docker and Kubernetes network troubleshooting can become complex. With proper understanding of how Docker and Kubernetes networking works and the right set of tools, you can troubleshoot and resolve these networking issues. The netshoot container has a set of powerful networking troubleshooting tools that can be used to troubleshoot Docker networking issues."- Nicola Kabar

- https://hub.docker.com/r/nicolaka/netshoot
```
docker build -t fredysa/netshoot:1.0 .
```
To use this container for debugging purposes, we can proceed as follows:

Spin up a throwaway bastion container for debugging on Kubernetes, using the following command:
Copy
$ kubectl run tmp-shell --generator=run-pod/v1 --rm -i --tty \
     --image fundamentalsofdocker/netshoot \
     --command -- bash
 
 bash-5.0#
You can now use tools such as ip from within this container:
Copy
bash-5.0# ip a
On my machine, this results in an output similar to the following if I run the pod on Docker for Windows:

Copy
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
 2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
 4: eth0@if263: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
     link/ether 52:52:9d:1d:fd:cc brd ff:ff:ff:ff:ff:ff link-netnsid 0
     inet 10.1.0.71/16 scope global eth0
        valid_lft forever preferred_lft forever
To leave this troubleshoot container, just press Ctrl + D or type exit and then hit Enter.
If we need to dig a bit deeper and run the container in the same network namespace as the Kubernetes host, then we can use this command instead:
Copy
$ kubectl run tmp-shell --generator=run-pod/v1 --rm -i --tty \
     --overrides='{"spec": {"hostNetwork": true}}' \
     --image fundamentalsofdocker/netshoot \
     --command -- bash
If we run ip again in this container, we will see everything that the container host sees too, for example, all the veth endpoints. 
The netshoot container has all the usual tools installed that an engineer ever needs to troubleshoot network-related problems. Some of the more familiar ones are ctop, curl, dhcping, drill, ethtool, iftop, iperf, and iproute2.