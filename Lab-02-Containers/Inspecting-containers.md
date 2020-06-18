# Inspecting containers
Containers are runtime instances of an image and have a lot of associated data that characterizes their behavior. To get more information about a specific container, we can use the **inspect** command. As usual, we have to provide either the container ID or name to identify the container of which we want to obtain the data. So, let's inspect our sample container:

```
$ docker container inspect trivia 
```
The response is a big JSON object full of details. It looks similar to this:
```
[
    {
        "Id": "48630a3bf188...",
        ...
        "State": {
            "Status": "running",
            "Running": true,
            ...
        },
        "Image": "sha256:bbc92c8f014d605...",
        ...
        "Mounts": [],
        "Config": {
            "Hostname": "48630a3bf188",
            "Domainname": "",
            ...
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "82aed83429263ceb6e6e...",
            ...
        }
    }
]
```
The output has been shortened for readability.

Please take a moment to analyze what you got. You should see information such as the following:

- The ID of the container
- The creation date and time of the container
- The image from which the container is built


Many sections of the output, such as **Mounts** or **NetworkSettings**, don't make much sense right now, but we will certainly discuss those in the upcoming chapters of this book. The data you're seeing here is also named the metadata of a container. We will be using the **inspect** command quite often in the remainder of this book as a source of information.

Sometimes, we need just a tiny bit of the overall information, and to achieve this, we can either use the grep tool or a filter. The former method does not always result in the expected answer, so let's look into the latter approach:

```
$ docker container inspect -f "{{json .State}}" trivia | jq .
```

The **-f** or **--filter** parameter is used to define the filter. The filter expression itself uses the Go template syntax. In this example, we only want to see the state part of the whole output in the JSON format.

To nicely format the output, we pipe the result into the **jq** tool:

```
{
  "Status": "running",
  "Running": true,
  "Paused": false,
  "Restarting": false,
  "OOMKilled": false,
  "Dead": false,
  "Pid": 18252,
  "ExitCode": 0,
  "Error": "",
  "StartedAt": "2019-06-16T13:30:15.776272Z",
  "FinishedAt": "2019-06-16T13:29:38.6412298Z"
}
```
After we have learned how to retrieve loads of important and useful meta information about a container, we now want to investigate how we can execute it in a running container.