# **The host and the null network**

In this section, we are going to look at two predefined and somewhat unique types of networks, the host and the null networks. Let's start with the former.

# The host network

There are occasions where we want to run a container in the network namespace of the host. This can be necessary when we need to run some software in a container that is used to analyze or debug the host networks' traffic. But keep in mind that these are very specific scenarios. When running business software in containers, there is no good reason to ever run the respective containers attached to the host's network. For security reasons, it is strongly recommended that you do not run any such container attached to the host network on a production or production-like environment.

That said, how can we run a container inside the network namespace of the host? Simply by attaching the container to the host network:

```
$ docker container run --rm -it --network host alpine:latest /bin/sh
```
If we use the ip tool to analyze the network namespace from within the container, we will see that we get exactly the same picture as we would if we were running the ip tool directly on the host. For example, if I inspect the eth0 device on my host, I get this:

```
/ # ip addr show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 02:50:00:00:00:01 brd ff:ff:ff:ff:ff:ff
    inet 192.168.65.3/24 brd 192.168.65.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::c90b:4219:ddbd:92bf/64 scope link
       valid_lft forever preferred_lft forever
```

Here, I can see that 192.168.65.3 is the IP address that the host has been assigned and that the MAC address shown here also corresponds to that of the host.

We can also inspect the routes to get the following (shortened):

```
/ # ip route
default via 192.168.65.1 dev eth0 src 192.168.65.3 metric 202
10.1.0.0/16 dev cni0 scope link src 10.1.0.1
127.0.0.0/8 dev lo scope host
172.17.0.0/16 dev docker0 scope link src 172.17.0.1
...
192.168.65.0/24 dev eth0 scope link src 192.168.65.3 metric 202
```
Before I let you go on to the next section of this chapter, I want to once more point out that the use of the host network is dangerous and needs to be avoided if possible.

# The null network
Sometimes, we need to run a few application services or jobs that do not need any network connection at all to execute the task at hand. It is strongly advised that you run those applications in a container that is attached to the none network. This container will be completely isolated, and is thus safe from any outside access. Let's run such a container:

```
$ docker container run --rm -it --network none alpine:latest /bin/sh
```
Once inside the container, we can verify that there is no eth0 network endpoint available:

```
/ # ip addr show eth0
ip: can't find device 'eth0'
```

There is also no routing information available, as we can demonstrate by using the following command:

```
/ # ip route
```
This returns nothing.
