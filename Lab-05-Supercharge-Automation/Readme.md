# **Using Docker to Supercharge Automation**
In the last chapter, we introduced techniques commonly used to allow a developer to evolve, modify, debug, and test their code while running in a container. We also learned how to instrument applications so that they generate logging information that can help us to do root cause analysis of failures or misbehaviors of applications or application services that are running in production.

In this chapter, we will show how you can use tools to perform administrative tasks without having to install those tools on the host computer. We will also illustrate the use of containers that host and run test scripts or code used to test and validate application services running in containers. Finally, we will guide the reader through the task of building a simple Docker-based CI/CD pipeline.

This is a quick overview of all of the subjects we are going to touch on in this chapter:

- [Cheat-Sheet Docker](Cheat-Sheet-Docker.md)
- [Executing simple admin tasks in a container](Executing-simple-admin-tasks-in-a-container.md)
- [Using test containers](Using-test-containers.md)


# Technical requirements
In this section, if you want to follow along with the code, you need Docker for Desktop on your macOS or Windows machine and a code editor, preferably Visual Studio Code. The sample will also work on a Linux machine with Docker and VS Code installed.

# Summary
In this chapter, we learned how to use Docker containers to optimize various kinds of automation tasks, from running a simple one-off task to building up a containerized CI/CD pipeline.

In the next chapter, we will introduce advanced tips, tricks, and concepts useful when containerizing complex distributed applications or when using Docker to automate sophisticated tasks.

# Further reading
Write Maintainable Integration Tests with Docker at https://www.docker.com/blog/maintainable-integration-tests-with-docker/ 