# Monitoring and Troubleshooting an App Running in Production

In the previous chapter, we learned how to deploy a multi-service application into a Kubernetes cluster. We configured application-level routing for the application and updated its services using a zero-downtime strategy. Finally, we provided confidential data to the running services by using Kubernetes Secrets.

In this chapter, you will learn the different techniques used to monitor an individual service or a whole distributed application running on a Kubernetes cluster. You will also learn how you can troubleshoot an application service that is running in production, without altering the cluster or the cluster nodes on which the service is running.

The chapter covers the following topics:

- [Monitoring an individual service](Monitoring-an-individual-service.md)
- Using Prometheus to monitor your distributed application
- Troubleshooting a service running in production

Technical requirements
In this chapter, we're going to use Minikube on our local computer. Please refer to  Setting Up a Working Environment, for more information on how to install and use Minikube.

The code for this chapter can be found at : **~lab-14-Kubernets-Monitoring** 
In your Terminal, navigate to the **~lab-14-Kubernets-Monitoring\sample** 
