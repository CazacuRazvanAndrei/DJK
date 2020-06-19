# **Debugging Code Running in Containers**
In the previous chapter, we learned how to work with stateful containers, that is, containers that consume and produce data. We also learned how to configure our containers at runtime and at image build time using environment variables and config files.

In this chapter, we're going to introduce techniques commonly used to allow a developer to evolve, modify, debug, and test their code while running in a container. With these techniques at hand, you will enjoy a frictionless development process for applications running in a container, similar to what you experience when developing applications that run natively.

Here is a list of the topics we're going to discuss:

- [Evolving and testing code running in a container](Evolving-and-testing-code-running-in-a-container.md)
- [Auto restarting code upon changes](Auto-restarting-code-upon-changes.md)
- [Line-by-line code debugging inside a container](Line-by-line-code-debugging-inside-a-container.md)
- [Instrumenting your code to produce meaningful logging information](Instrumenting-your-code-to-produce-meaningful-logging-information.md)
- [Using Jaeger to monitor and troubleshoot](Using-Jaeger-to-monitor-and-troubleshoot.md)

# Technical requirements
In this chapter, if you want to follow along with the code, you need Docker for Desktop on macOS or Windows and a code editor—preferably Visual Studio Code. The sample will also work on a Linux machine with Docker and VS Code installed.

# Summary
In this chapter, we have learned how to debug Node.js, Python, Java, and .NET code running inside a container. We first started by mounting the source code from the host into the container to avoid a rebuild of the container image each time the code changes. Then, we smoothed out the development process further by enabling automatic application restart inside the container upon code changes. Next, we learned how to configure Visual Studio Code to enable the full interactive debugging of code running inside a container. Finally, we learned how we can instrument our applications such that they generate logging information that can help us to do root cause analysis on failures or misbehaving applications or application services running in production.

In the next chapter, we are going to show how using Docker containers can super-charge your automation, from running a simple automation task in a container, to using containers to build up CI/CD pipelines.

# Further reading
- Live debugging with Docker: https://www.docker.com/blog/live-debugging-docker/
- Debug apps in a local Docker container: https://docs.microsoft.com/en-us/visualstudio/containers/edit-and-refresh?view=vs-2019
- Debug your java applications in Docker using IntelliJ IDEA: https://blog.jetbrains.com/idea/2019/04/debug-your-java-applications-in-docker-using-intellij-idea/
