# Monitoring and Troubleshooting an App Running in Production

In the previous chapter, we learned how to deploy a multi-service application into a Kubernetes cluster. We configured application-level routing for the application and updated its services using a zero-downtime strategy. Finally, we provided confidential data to the running services by using Kubernetes Secrets.

In this chapter, you will learn the different techniques used to monitor an individual service or a whole distributed application running on a Kubernetes cluster. You will also learn how you can troubleshoot an application service that is running in production, without altering the cluster or the cluster nodes on which the service is running.

The chapter covers the following topics:

- [Monitoring an individual service](Monitoring-an-individual-service.md)
- [Using Prometheus to monitor your distributed application](Using-Prometheus-to-monitor-your-distributed-application.md)
- [Troubleshooting a service running in production](Troubleshooting-a-service-running-in-production.md)

# Technical requirements
In this chapter, we're going to use Minikube on our local computer. Please refer to  Setting Up a Working Environment, for more information on how to install and use Minikube.

The code for this chapter can be found at : **~lab-14-Kubernets-Monitoring** 
In your Terminal, navigate to the **~lab-14-Kubernets-Monitoring\sample** 


# Summary
In this chapter, you learned some techniques used to monitor an individual service or a whole distributed application running on a Kubernetes cluster. Furthermore, you investigated troubleshooting an application service that is running in production without having to alter the cluster or the cluster nodes on which the service is running.

In the next and final chapter of this book, you will gain an overview of some of the most popular ways of running containerized applications in the cloud. The chapter includes samples on how to self-host and use hosted solutions and discuss their pros and cons. Fully managed offerings of vendors such as Microsoft Azure and Google Cloud Engine are briefly discussed.

# Further reading
Here are a few links that provide additional information on the topics discussed in this chapter:

- Kubernetes Monitoring with Prometheus: https://sysdig.com/blog/kubernetes-monitoring-prometheus/
- Prometheus Client Libraries: https://prometheus.io/docs/instrumenting/clientlibs/
- The netshoot container: https://github.com/nicolaka/netshoot