# **Debugging Code Running in Containers**
In the previous chapter, we learned how to work with stateful containers, that is, containers that consume and produce data. We also learned how to configure our containers at runtime and at image build time using environment variables and config files.

In this chapter, we're going to introduce techniques commonly used to allow a developer to evolve, modify, debug, and test their code while running in a container. With these techniques at hand, you will enjoy a frictionless development process for applications running in a container, similar to what you experience when developing applications that run natively.

Here is a list of the topics we're going to discuss:

- [Evolving and testing code running in a container](Evolving-and-testing-code-running-in-a-container.md)
- [Auto restarting code upon changes]()
- [Line-by-line code debugging inside a container]()
- [Instrumenting your code to produce meaningful logging information]()
- [Using Jaeger to monitor and troubleshoot]()

# Technical requirements
In this chapter, if you want to follow along with the code, you need Docker for Desktop on macOS or Windows and a code editor—preferably Visual Studio Code. The sample will also work on a Linux machine with Docker and VS Code installed.
