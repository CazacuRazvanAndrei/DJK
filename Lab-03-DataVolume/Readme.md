# **Data Volumes and Configuration**
In the last chapter, we learned how to build and share our own container images. Particular focus was placed on how to build images that are as small as possible by only containing artifacts that are really needed by the containerized application.

In this chapter, we are going to learn how we can work with stateful containers—that is, containers that consume and produce data. We will also learn how to configure our containers at runtime and at image build time, using environment variables and config files.

Here is a list of the topics we're going to discuss:

- [Creating and mounting data volumes](Creating-and-mounting-data-volumes.md)
- [Sharing data between containers]()
- [Using host volumes]()
- [Defining volumes in images]()
- [Configuring containers]()

# Technical requirements
For this chapter, you need either Docker Toolbox installed on your machine or access to a Linux virtual machine (VM) running Docker on your laptop or in the cloud. Furthermore, it is advantageous to have Docker for Desktop installed on your machine. There is no code accompanying this chapter.