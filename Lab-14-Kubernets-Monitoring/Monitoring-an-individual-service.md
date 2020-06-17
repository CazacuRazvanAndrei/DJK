# Monitoring an individual service
When working with a distributed mission-critical application in production or in any production-like environment, then it is of utmost importance to gain as much insight as possible into the inner workings of those applications. Have you ever had a chance to look into the cockpit of an airplane or the command center of a nuclear power plant? Both the airplane and the power plant are samples of highly complex systems that deliver mission-critical services. If a plane crashes or a power plant shuts down unexpectedly, a lot of people are negatively affected, to say the least. Thus the cockpit and the command center are full of instruments showing the current or past state of some part of the system. What you see is the visual representation of some sensors that are placed in strategic parts of the system, and constantly collect data such as the temperature or the flow rate. 

Similar to the airplane or the power plant, our application needs to be instrumented with "sensors" that can feel the "temperature" of our application services or the infrastructure they run on. I put the temperature in double quotes since it is only a placeholder for things that matter in an application, such as the number of requests per second on a given RESTful endpoint, or the average latency of request to the same endpoint.

The resulting values or readings that we collect, such as the average latency of requests, are often called metrics. It should be our goal to expose as many meaningful metrics as possible of the application services we build. Metrics can be both functional and non-functional. Functional metrics are values that say something business-relevant about the application service, such as how many checkouts are performed per minute if the service is part of an e-commerce application, or which are the five most popular songs over the last 24 hours if we're talking about a streaming application.

Non-functional metrics are important values that are not specific to the kind of business the application is used for, such as what is the average latency of a particular web request or how many **4xx** status codes are returned per minute by another endpoint, or how much RAM or how many CPU cycles a given service is using. 

In a distributed system where each part is exposing metrics, some overarching service should be collecting and aggregating the values periodically from each component. Alternatively, each component should forward its metrics to a central metrics server. Only if the metrics for all components of our highly distributed system are available for inspection in a central location are they of any value. Otherwise, monitoring the system becomes impossible. That's why pilots of an airplane never have to go and inspect individual and critical parts of the airplane in person during a flight; all necessary readings are collected and displayed in the cockpit.

Today one of the most popular services that is used to expose, collect, and store metrics is Prometheus. It is an open source project and has been donated to the **Cloud Native Computing Foundation (CNCF)**. Prometheus has first-class integration with Docker containers, Kubernetes, and many other systems and programming platforms. In this chapter, we will use Prometheus to demonstrate how to instrument a simple service that exposes important metrics.

# Instrumenting a Node.js-based service
In this section, we want to learn how to instrument a microservice authored in Node Express.js by following these steps:

1. Create a new folder called node and navigate to it:

```
mkdir node 
cd node
```

2. Run **npm init** in this folder, and accept all defaults except the **entry point**, which you change from the **index.js** default to **server.js**.
3. We need to add express to our project with the following:

```
npm install --save express
```

4. Now we need to install the Prometheus adapter for Node Express with the following:
 
```
$ npm install --save prom-client
```

5. Add a file called **server.js** to the folder with this content:

```
const app = require("express")();

app.get('/hello', (req, res) => {
  const { name = 'World' } = req.query;
  res.json({ message: `Hello, ${name}!` });
});

app.listen(port=3000, () => {
  console.log(`Example api is listening on http://localhost:3000`);
}); 
```

This is a very simple Node Express app with a single endpoint: **/hello**. 

6. To the preceding code, add the following snippet to initialize the Prometheus client:
```
const client = require("prom-client");
const register = client.register;
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ register });
```

7. Next, add an endpoint to expose the metrics:

```
app.get('/metrics', (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(register.metrics());
});
```

8. Now let's run this sample microservice:
```
$ npm start

> node@1.0.0 start ~lab-14-..\sample\node
> node server.js

Example api is listening on http://localhost:3000

```

We can see in the preceding output that the service is listening at port **3000**.

8.1. Let's now try to access the metrics at the **/metrics** endpoint, as we defined in the code:

```
$ curl localhost:3000/metrics
...
process_cpu_user_seconds_total 0.016 1577633206532

# HELP process_cpu_system_seconds_total Total system CPU time spent in seconds.
# TYPE process_cpu_system_seconds_total counter
process_cpu_system_seconds_total 0.015 1577633206532

# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 0.031 1577633206532
...
nodejs_version_info{version="v10.15.3",major="10",minor="15",patch="3"} 1
```

What we get as output is a pretty long list of metrics, ready for consumption by a Prometheus server.

This was pretty easy, wasn't it? By adding a node package and adding a few trivial lines of code to our application startup, we have gained access to a plethora of system metrics.

Now let's define our own custom metric. Let it be a **Counter**object:

1. Add the following code snippet to **server.js** to define a custom counter called **my_hello_counter**:

```
const helloCounter = new client.Counter({ 
  name: 'my_hello_counter', 
  help: 'Counts the number of hello requests',
});
```

2. To our existing **/hello** endpoint, add code to increase the counter:
```
app.get('/hello', (req, res) => {
  helloCounter.inc();
  const { name = 'World' } = req.query;
  res.json({ message: `Hello, ${name}!` });
});
```
3. Rerun the application with **npm start**.
4. To test the new counter, let's access our **/hello** endpoint twice:
```
curl localhost:3000/hello?name=Sue
```
5. We will get this output when accessing the **/metrics** endpoint:

```
$ curl localhost:3000/metrics
PS:
(curl http://localhost:3000/metrics).content
...
# HELP my_hello_counter Counts the number of hello requests 
# TYPE my_hello_counter counter
my_hello_counter 2
```
Build\Run Docker
```
cd ~...\sample\node
docker build -t fredysa/nodeks:1.0 .
docker run --rm --name hellocounters -p 3000:3000 fredysa/nodeks:1.0
```

The counter we defined in code clearly works and is output with the **HELP** text we added.

Now that we know how to instrument a Node Express application, let's do the same for a .NET Core-based microservice.

# Instrumenting a .NET Core-based service
Let's start by creating a simple .NET Core microservice based on the Web API template.

1. Create a new dotnet folder, and navigate to it:
```
mkdir dotnet
cd dotnet
choco install dotnetcore-sdk -y
```
2. Use the **dotnet** tool to scaffold a new microservice called **sample-api**:
```
dotnet new webapi --output sample-api
```

3. We will use the Prometheus adapter for .NET, which is available to us as a NuGet package called prometheus-net.AspNetCore. Add this package to the sample-api project, with the following command:

```
 dotnet add sample-api package prometheus-net.AspNetCore
```

4. Open the project in your favorite code editor; for example, when using VS Code execute the following:
```
code .
```
Locate the **Startup.cs** file, and open it. At the beginning of the file, add a **using**statement:
```
using Prometheus; 
```
Then in the Configure method add the endpoints.MapMetrics() statement to the mapping of the endpoints. Your code should look as follows:

```
public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    ...
    app.UseEndpoints(endpoints =>
    {
        endpoints.MapControllers();
        endpoints.MapMetrics();
    });
}
```
- **Tip:**
Note that the above is valid for version 3.x of .NET Core. If you're on an earlier version, the configuration looks slightly different. Consult the following repo for more details, at https://github.com/prometheus-net/prometheus-net.


7. With this, the Prometheus component will start publishing the request metrics of ASP.NET Core. Let's try it. First, start the application with the following:

```
dotnet run --project sample-api

info: Microsoft.Hosting.Lifetime[0]
      Now listening on: https://localhost:5001 
info: Microsoft.Hosting.Lifetime[0]
      Now listening on: http://localhost:5000 
...
```

The preceding output tells us that the microservice is listening at **https://localhost:5001**.

We can now use curl to call the metrics endpoint of the service:
```
start https://localhost:5001/metrics 
```
```
# HELP process_private_memory_bytes Process private memory size
# TYPE process_private_memory_bytes gauge
process_private_memory_bytes 55619584
# HELP process_virtual_memory_bytes Virtual memory size in bytes. 
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 2221930053632
# HELP process_working_set_bytes Process working set
# TYPE process_working_set_bytes gauge
process_working_set_bytes 105537536
...
dotnet_collection_count_total{generation="1"} 0
dotnet_collection_count_total{generation="0"} 0
dotnet_collection_count_total{generation="2"} 0
```

What we get is a list of system metrics for our microservice. That was easy: we only needed to add a NuGet package and a single line of code to get our service instrumented!

What if we want to add our own (functional) metrics? This is equally straightforward. Assume we want to measure the number of concurrent accesses to our **/weatherforecas**t endpoint. To do this, we define a gauge and use it to wrap the logic in the appropriate endpoint with this **gauge**. We can do this by following these steps:

Locate the **Controllers/WeatherForecastController.cs** class.
Add using Prometheus; to the top of the file.
Define a private instance variable of the Gauge type in the WeatherForecastController class:

```
private static readonly Gauge weatherForecastsInProgress = Metrics
    .CreateGauge("myapp_weather_forecasts_in_progress", 
                 "Number of weather forecast operations ongoing.");
```
Wrap the logic of the Get method with a using statement:
Copy
[HttpGet]
public IEnumerable<WeatherForecast> Get()
{
    using(weatherForecastsInProgress.TrackInProgress())
    {
        ...
    }
}
Restart the microservice.
Call the /weatherforecast endpoint a couple of times using curl:
Copy
$ curl --insecure https://localhost:5001/weatherforecast
Use curl to get the metrics, as earlier in this section:
Copy
$ curl --insecure https://localhost:5001/metrics 

# HELP myapp_weather_forecasts_in_progress Number of weather forecast operations ongoing.
# TYPE myapp_weather_forecasts_in_progress gauge
myapp_weather_forecasts_in_progress 0
...
You will notice that there is now a new metric called myapp_weather_forecasts_in_progress available in the list. Its value will be zero, since currently you are not running any requests against the tracked endpoint, and a gauge type metric is only measuring the number of ongoing requests.

Congratulations, you have just defined your first functional metric. This is only a start; many more sophisticated possibilities are readily available to you.

Node.js or .NET Core-based application services are by no means special. It is just as straightforward and easy to instrument services written in other languages, such as Java, Python, or Go.

Having learned how to instrument an application service so that it exposes important metrics, let's now have a look how we can use Prometheus to collect and aggregate those values to allow us to monitor a distributed application.