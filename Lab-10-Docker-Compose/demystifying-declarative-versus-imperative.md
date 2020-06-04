# Demystifying declarative versus imperative

Docker Compose is a tool provided by Docker that is mainly used where you need to run and orchestrate containers running on a single Docker host. This includes, but is not limited to, development, **continuous integration (CI)**, automated testing, manual QA, or demos.

Docker Compose uses files formatted in YAML as input. By default, Docker Compose expects these files to be called **docker-compose.yml**, but other names are possible. The content of a **docker-compose.yml** is said to be a declarative way of describing and running a containerized application potentially consisting of more than a single container.

So, what is the meaning of declarative?

First of all, declarative is the antonym of imperative. Well, that doesn't help much. Now that I have introduced another definition, I need to explain both of them:

- **Imperative:** *This is a way in which we can solve problems by specifying the exact procedure that has to be followed by the system.*

If I tell a system such as the Docker daemon imperatively how to run an application, then that means that I have to describe step by step what the system has to do and how it has to react if some unexpected situation occurs. I have to be very explicit and precise in my instructions. I need to cover all edge cases and how they need to be treated.

- **Declarative:** *This is a way in which we can solve problems without requiring the programmer to specify an exact procedure to be followed.*

A declarative approach means that I tell the Docker engine what my desired state for an application is and it has to figure out on its own how to achieve this desired state and how to reconcile it if the system deviates from it.

Docker clearly recommends the declarative approach when dealing with containerized applications. Consequently, the Docker Compose tool uses this approach. 