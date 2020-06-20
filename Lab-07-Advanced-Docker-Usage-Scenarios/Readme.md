# **Advanced Docker Usage Scenarios**
In the last chapter, we showed you how you can use tools to perform administrative tasks without having to install those tools on the host computer. We also illustrated the use of containers that host and run test scripts or code used to test and validate application services running in containers. Finally, we guided you through the task of building a simple Docker-based CI/CD pipeline using Jenkins as the automation server.

In this chapter, we will introduce advanced tips, tricks, and concepts that are useful when containerizing complex distributed applications, or when using Docker to automate sophisticated tasks.

This is a quick overview of all of the subjects we are going to touch on in this chapter:

- [All of the tips and tricks of a Docker pro](All-of-the-tips-and-tricks-of-a-Docker-pro.md)
- [Running your Terminal in a remote container and accessing it via HTTPS](Running-your-Terminal-in-a-remote-container-and-accessing-it-via-HTTPS.md)
- [Running your development environment inside a container](Running-your-development-environment-inside-a-container.md)
- [Running your code editor in a remote container and accessing it via HTTPS](Running-your-code-editor-in-a-remote-container-and-accessing-it-via-HTTPS.md)

# Technical requirements
In this chapter, if you want to follow along with the code, you need Docker for Desktop on your Mac or Windows machine and the Visual Studio Code editor. The example will also work on a Linux machine with Docker and Visual Studio Code installed. Docker Toolbox is not supported in this chapter.

# Summary
In this chapter, we have shown a few tips and tricks for the advanced Docker user that can make your life much more productive. We have also shown how you can leverage containers to serve whole development environments that run on remote servers and can be accessed from within a browser over a secure HTTPS connection.

In the next chapter, we will introduce the concept of a distributed application architecture and discuss the various patterns and best practices that are required to run a distributed application successfully. In addition to that, we will list some of the concerns that need to be fulfilled to run such an application in production or a production-like environment.

# Further reading
- Using Docker in Docker at http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
- Shell in a Box at https://github.com/shellinabox/shellinabox
- Remote development using SSH at https://code.visualstudio.com/docs/remote/ssh
- Developing inside a container at https://code.visualstudio.com/docs/remote/containers