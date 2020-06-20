# Single-Host Networking

In this chapter, we will introduce the Docker container networking model and its single-host implementation in the form of the bridge network. This chapter also introduces the concept of software-defined networks and how they are used to secure containerized applications. Furthermore, we will demonstrate how container ports can be opened to the public and thus make containerized components accessible to the outside world. Finally, we will introduce Traefik, a reverse proxy, which can be used to enable sophisticated HTTP application-level routing between containers.

- [Dissecting the container network model](Single-Host-Networking.md)
- [Network Firewall](Network-Firewall.md)
- [Working with bridge networking ](Working-with-bridge-networking.md)
- [The host and the null network](The_host_and_null_network.md)
- [Running in an existing network names](Running_in_an_existing_network_names.md)
- [Managing container port](Managing-container-port.md)
- [Nginx Reverse Proxy](NGINX-Reverse-Proxy.md)
- [Nginx Reverse ProxyII](Nginx-Reverse-Proxy_II.md)


# Technical requirements
For this chapter, the only thing you will need is a Docker host that is able to run Linux containers. You can use your laptop with either Docker for macOS or Windows or have Docker Toolbox installed.

# Summary
In this chapter, we have learned about how containers running on a single host can communicate with each other. First, we looked at the CNM, which defines the requirements of a container network, and then we investigated several implementations of the CNM, such as the bridge network. We then looked at how the bridge network functions in detail and also what kind of information Docker provides us with about the networks and the containers attached to those networks. We also learned about adopting two different perspectives, from both outside and inside the container. Last but not least we introduced Traefik as a means to provide application level routing to our applications.

# Further reading
Here are some articles that describe the topics that were presented in this chapter in more detail:

- Docker networking overview: http://dockr.ly/2sXGzQn
- Container networking: http://dockr.ly/2HJfQKn
- What is a bridge?: https://bit.ly/2HyC3Od
- Using bridge networks: http://dockr.ly/2BNxjRr
- Using Macvlan networks: http://dockr.ly/2ETjy2x
- Networking using the host network: http://dockr.ly/2F4aI59
- Reverse proxy : https://dev.to/sukhbirsekhon/what-is-docker-reverse-proxy-45mm
