# What Are Containers and Why Should I Use Them?

These days, the time between new releases of an application become shorter and shorter, yet the software itself doesn't become any simpler. On the contrary, software projects increase in complexity. Thus, we need a way to tame the beast and simplify the software supply chain.

Also, every day, we hear that cyber-attacks are on the rise. Many well-known companies are and have been affected by security breaches. Highly sensitive customer data gets stolen during such events, such as social security numbers, credit card information, and more. But not only customer data is compromised – sensitive company secrets are stolen too.

Containers can help in many ways. First of all, Gartner found that applications running in a container are more secure than their counterparts not running in a container. Containers use Linux security primitives such as Linux kernel namespaces to sandbox different applications running on the same computers and control groups (cgroups) in order to avoid the noisy-neighbor problem, where one bad application is using all the available resources of a server and starving all other applications.

Due to the fact that container images are immutable, it is easy to have them scanned for common vulnerabilities and exposures (CVEs), and in doing so, increase the overall security of our applications.

Another way to make our software supply chain more secure is to have our containers use a content trust. A content trust basically ensures that the author of a container image is who they pretend to be and that the consumer of the container image has a guarantee that the image has not been tampered with in transit. The latter is known as a man-in-the-middle (MITM) attack.

Everything I have just said is, of course, technically also possible without using containers, but since containers introduce a globally accepted standard, they make it so much easier to implement these best practices and enforce them.

OK, but security is not the only reason why containers are important. There are other reasons too.

One is the fact that containers make it easy to simulate a production-like environment, even on a developer's laptop. If we can containerize any application, then we can also containerize, say, a database such as Oracle or MS SQL Server. Now, everyone who has ever had to install an Oracle database on a computer knows that this is not the easiest thing to do, and it takes up a lot of precious space on your computer. You wouldn't want to do that to your development laptop just to test whether the application you developed really works end-to-end. With containers at hand, we can run a full-blown relational database in a container as easily as saying 1, 2, 3. And when we're done with testing, we can just stop and delete the container and the database will be gone, without leaving a trace on our computer.

Since containers are very lean compared to VMs, it is not uncommon to have many containers running at the same time on a developer's laptop without overwhelming the laptop.

A third reason why containers are important is that operators can finally concentrate on what they are really good at: provisioning the infrastructure and running and monitoring applications in production. When the applications they have to run on a production system are all containerized, then operators can start to standardize their infrastructure. Every server becomes just another Docker host. No special libraries or frameworks need to be installed on those servers, just an OS and a container runtime such as Docker.

Also, operators do not have to have intimate knowledge of the internals of applications anymore, since those applications run self-contained in containers that ought to look like black boxes to them, similar to how shipping containers look to the personnel in the transportation industry.