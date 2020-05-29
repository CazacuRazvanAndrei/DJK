# Scenario 3 - Host - Share volume
### In certain scenarios, such as when developing new containerized applications or when a containerized application needs to consume data from a certain folder produced—say—by a legacy application, it is very useful to use volumes that mount a specific host folder. Let's look at the following example:


# Version 1

```powershell
mkdir demo
docker container run --rm -it -v $pwd/demo:/app/src alpine:latest /bin/sh

# cd /app/src/
# echo "<h1>Personal Website</h1>" > index.html  

```

# Build docker file
```dockerfile
docker image build -t my-website:1.0 .
```

# run 
docker container run -d --name my-site -p 8080:80 my-website:1.0

```dockerfile
-v add local volume to continer
```

```

# Version 2

#ps: cd... \Lab03-DataVolume
docker container run -d --name my-site -v $pwd/src:/usr/share/nginx/html -p 8080:80 my-website:1.0
```

## Now, open a browser tab and navigate to 
http://localhost:8080/index.html


