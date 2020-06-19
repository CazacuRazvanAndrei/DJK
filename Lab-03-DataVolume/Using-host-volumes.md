# **Using host volumes**
In certain scenarios, such as when developing new containerized applications or when a containerized application needs to consume data from a certain folder produced—say—by a legacy application, it is very useful to use volumes that mount a specific host folder. Let's look at the following example:


```
$ docker container run --rm -it \
    -v $(pwd)/src:/app/src \
    alpine:latest /bin/sh
```
```
PS> docker container run --rm -it -v $pwd/src:/app/src alpine:latest /bin/sh
```

The preceding expression interactively starts an **alpine** container with a shell and mounts the src subfolder of the current directory into the container at /app/src. We need to use **$(pwd) (or `pwd`, for that matter $pwd in Powershell)**, which is the current directory, as when working with volumes, we always need to use absolute paths.

Developers use these techniques all the time when they are working on their application that runs in a container, and want to make sure that the container always contains the latest changes they make to the code, without the need to rebuild the image and rerun the container after each change.

- Let's make a sample to demonstrate how that works. Let's say we want to create a simple static website using nginx as our web server as follows:

First, let's create a new folder on the host, where we will put our web assets—such as HTML, CSS, and JavaScript files—and navigate to it, like this:
```
$ mkdir ~/my-web 
$ cd ~/my-web 
```
Then, we create a simple web page, like this:

```
$ echo "<h1>Personal Website</h1>" > index.html  
```
Now, we add a **Dockerfile** that will contain instructions on how to build the image containing our sample website.

Add a file called Dockerfile to the folder, with this content:

```
FROM nginx:alpine
COPY . /usr/share/nginx/html
```

The **Dockerfile** starts with the latest Alpine version of nginx, and then copies all files from the current host directory into the **/usr/share/nginx/html** containers folder. This is where nginx expects web assets to be located.

Now, let's build the image with the following command:

```
$ docker image build -t my-website:1.0 . 
```

And finally, we run a container from this image. We will run the container in detached mode, like this:

```
$ docker container run -d --name my-site -p 8080:80 my-website:1.0
```

Note the **-p 8080:80** parameter. We haven't discussed this yet, but we will do it in detail in Single-Host Networking. At the moment, just know that this maps the container port 80 on which nginx is listening for incoming requests to port 8080 of your laptop, where you can then access the application.

Now, open a browser tab and navigate to http://localhost:8080/index.html, and you should see your website, which currently consists only of a title, Personal Website.
Now, edit the index.html file in your favorite editor, to look like this:
```
<h1>Personal Website</h1> 
<p>This is some text</p> 
```
Now, save it, and then refresh the browser. Oh! That didn't work. The browser still displays the previous version of the index.html file, which consists only of the title. So, let's stop and remove the current container, then rebuild the image, and rerun the container, as follows:

```
$ docker container rm -f my-site
$ docker image build -t my-website:1.0 .
$ docker container run -d \
   --name my-site \
   -p 8080:80 \
   my-website:1.0
```

This time, when you refresh the browser, the new content should be shown. Well, it worked, but there is way too much friction involved. Imagine you have to do this each and every time that you make a simple change to your website. That's not sustainable.

Now is the time to use host-mounted volumes. Once again, remove the current container and rerun it with the volume mount, like this:

Navigate to **~\DJK\Lab-03..\sample\**

```
$ docker container rm -f my-site
$ docker container run -d \
   --name my-site \
   -v $(pwd):/usr/share/nginx/html \
   -p 8080:80 \
   my-website:1.0

PS> docker container run -d `
   --name my-site `
   -v $pwd/src/:/usr/share/nginx/html `
   -p 8080:80 `
   my-website:1.0

```

Now, append some more content to the **index.html** file, and save it. Then, refresh your browser. You should see the changes. And this is exactly what we wanted to achieve; we also call this an edit-and-continue experience. You can make as many changes in your web files and always immediately see the result in the browser, without having to rebuild the image and restart the container containing your website.

It is important to note that the updates are now propagated bi-directionally. If you make changes on the host, they will be propagated to the container, and vice versa. Also important is the fact that when you mount the current folder into the container target folder, **/usr/share/nginx/html**, the content that is already there is replaced by the content of the host folder.