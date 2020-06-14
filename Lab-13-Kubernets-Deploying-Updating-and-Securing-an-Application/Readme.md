# Deploying, Updating, and Securing an Application with Kubernetes

In the previous chapter, we learned about the basics of the container orchestrator, Kubernetes. We got a high-level overview of the architecture of Kubernetes and learned a lot about the important objects used by Kubernetes to define and manage a containerized application. 

In this chapter, we will learn how to deploy, update, and scale applications into a Kubernetes cluster. We will also explain how zero downtime deployments are achieved to enable disruption-free updates and rollbacks of mission-critical applications. Finally, we will introduce Kubernetes secrets as a means to configure services and protect sensitive data.

# This chapter covers the following topics:

- [Deploying a first application](Deploying-a-first-application.md)
- Defining liveness and readiness
- Zero downtime deployments
- Kubernetes secrets

# Technical requirements
In this chapter, we're going to use Minikube on our local computer.  Setting Up a Working Environment, for more information on how to install and use Minikube.

```
kubectl config use-context minikube

minikube start
```

The code for this chapter can be found here: cd .\Lab-13-Kubernets-Deploying-Updating-and-Securing-an-Application\sample

In your Terminal, navigate to the **~/Lab-13-Kubernets-Deploying-Updating-and-Securing-an-Application/sample** folder.