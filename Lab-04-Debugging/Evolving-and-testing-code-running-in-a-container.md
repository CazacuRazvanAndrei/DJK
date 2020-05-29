# Evolving and testing code running in a container

```powershell
mkdir npm
cd .\npm\
```

### Create dockerfile 
```dockerfile
FROM node:latest
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
CMD node index.js
```


### Create  index.js
```nodejs
const express = require('express');
const app = express();

app.listen(3000, '0.0.0.0', ()=>{
    console.log('Application listening at 0.0.0.0:3000');
})

app.get('/', (req,res)=>{
    res.send('Sample Application: Hello World!');
})
```


```powershell
docker image build -t sample-app .

docker container run --rm -it --name my-sample-app -p 3000:3000  sample-app
```
### Add Hobies in index.js

```nodejs
const express = require('express');
const app = express();
const hobbies = [
    'Swimming', 'Diving', 'Jogging', 'Cooking', 'Singing'
  ];
  

app.listen(3000, '0.0.0.0', ()=>{
    console.log('Application listening at 0.0.0.0:3000');
})

app.get('/', (req,res)=>{
    res.send('Sample Application: Hello World!');
})
  app.get('/hobbies', (req,res)=>{
    res.send(hobbies);
  })
```

## Re run 
```powershell
docker image build -t sample-app .

docker container run --rm -it --name my-sample-app -p 3000:3000  sample-app
```

###  **Open Url** : localhost:3000/hobbies


# Mounting evolving code into the running container

```powershell
docker container run --rm -it --volume ~/app:/app sample-app /bin/sh
```


### ! if app is instaled localy 
```powershell
docker container run --rm -it --name my-sample-app --volume $(pwd):/app -p 3000:3000 sample-app

```

**Tip :** For all those working on Windows and/or Docker for Windows, you can use the PowerShell command **Invoke-WebRequest** or **iwr** for short instead of **curl**. The equivalent to the preceding command would then be **iwr -Url localhost:3000/status**.

docker container run --rm -it \
   --name my-sample-app \
   -p 3000:3000 \
   -p 9229:9229 \
      sample-app node --inspect=0.0.0.0 index.js


# Debug Jagger

docker run -d --name jaeger \
   -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
   -p 5775:5775/udp \
   -p 6831:6831/udp \
   -p 6832:6832/udp \
   -p 5778:5778 \
   -p 16686:16686 \
   -p 14268:14268 \
   -p 9411:9411 \
   jaegertracing/all-in-one:1.13