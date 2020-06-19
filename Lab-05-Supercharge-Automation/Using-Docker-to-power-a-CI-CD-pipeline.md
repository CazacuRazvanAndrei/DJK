Using Docker to power a CI/CD pipeline
The goal of this section is to build a CI/CD pipeline that looks like this:



A simple CI/CD pipeline using Jenkins
We are going to use Jenkins (https://jenkins.io) as our automation server. Other automation servers such as TeamCity (https://www.jetbrains.com/teamcity) work equally well. When using Jenkins, the central document is the Jenkinsfile, which will contain the definition of the pipeline with its multiple stages.

A simple Jenkinsfile with the Build, Test, Deploy to Staging, and Deploy to Production stages could look like this:

Copy
pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
            }
        }
        stage('Deploy to Staging') {
            steps {
                echo 'Deploying to Staging'
            }
        }
        stage('Deploy to Production') {
            steps {
                echo 'Deploying to Production'
            }
        }
    }
}
Of course, the preceding pipeline just outputs a message during each stage and does nothing else. It is useful though as a starting point from which to build up our pipeline:

Create a project folder named jenkins-pipeline and navigate to it:
Copy
$ mkdir ~/fod/ch07/jenkins-pipeline && cd ~/fod/ch07/jenkins-pipeline
Now, let's run Jenkins in a Docker container. Use the following command to do so:
Copy
$ docker run --rm -d \
   --name jenkins \
   -u root \
   -p 8080:8080 \
   -v jenkins-data:/var/jenkins_home \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v "$HOME":/home \
   jenkinsci/blueocean
Note that we are running as the root user inside the container and that we are mounting the Docker socket into the container (-v /var/run/docker.sock:/var/run/docker.sock) so that Jenkins can access Docker from within the container. Data produced and used by Jenkins will be stored in the Docker volume, jenkins-data.

We can find the initial admin password generated automatically by Jenkins with the following command:
Copy
$ docker container exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
In my case, this outputs 7f449293de5443a2bbcb0918c8558689. Save this password as you will be using it in the next step. 

In your browser, navigate to http://localhost:8080 to access the graphical UI of Jenkins.
Unlock Jenkins with the admin password that you retrieved with the previous command.
Next, choose Install suggested plugins to have Jenkins automatically install the most useful plugins. Plugins include the GitHub integration, an email extension, Maven and Gradle integration, and so on.
As soon as the plugins are installed, create your first admin account. When asked to restart Jenkins, do so.
Once you have configured your Jenkins server, start by creating a new project; you may need to click New Item in the main menu:


Add a new project in Jenkins
Give the project the name sample-pipeline, select the Pipeline type, and click OK.
In the configuration view, select the Pipeline tab and add the pipeline definition from the preceding into the Script textbox:


Defining the pipeline in our Jenkins project called sample-pipeline
Click Save and then, in the main menu of Jenkins, select Build Now. After a short moment, you should see this:


Running our sample pipeline in Jenkins
Now that we have prepared Jenkins, we can start to integrate our sample application. Let's start with the build step. First, we initialize the jenkins-pipeline project folder as a Git project:
Copy
$ cd ~/fod/ch07/jenkins-pipeline && git init
Add a package.json file to this folder with this content:
Copy
{
  "name": "jenkins-pipeline",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "test": "jasmine"
  },
  "dependencies": {
    "express": "^4.17.1"
  },
  "devDependencies": {
    "jasmine": "^3.4.0"
  }
}
There is nothing exceptional in this file other the usual list of external dependencies, express and jasmine, in this case. Also, note the two scripts start and test that we define for use with npm.

Add a hobbies.js file to the project, which implements the logic to retrieve hobbies as a JavaScript module called hobbies:
Copy
const hobbies = ["jogging","cooking","diving","swimming","reading"];

exports.getHobbies = () => {
    return hobbies;
}

exports.getHobby = id => {
    if(id<1 || id > hobbies.length)
        return null;
    return hobbies[id-1];
}
This code evidently is simulating a database by serving pre-canned data stored in the hobbies array. We do this for simplicity.

Next add a server.js file to the folder that defines a RESTful API with the three endpoints, GET /,  GET /hobbies, and GET /hobbies/:id. The code uses the logic defined in the hobbies module to retrieve data:
Copy
const hobbies = require('./hobbies');
const express = require('express');
const app = express();

app.listen(3000, '0.0.0.0', () => {
    console.log('Application listening at 0.0.0.0:3000');
})

app.get('/', (req, res) => {
    res.send('Sample API');
})

app.get('/hobbies', async (req, res) => {
    res.send(hobbies.getHobbies());
})

app.get('/hobbies/:id', async (req, res) => {
    const id = req.params.id;
    const hobby = hobbies.getHobby(id);
    if(!hobby){
        res.status(404).send("Hobby not found");
        return;
    }
    res.send();
})
Now we need to define some unit tests. Create a spec subfolder in the project and add the hobbies-spec.js file to it with the following code that tests the hobbies module:
Copy
const hobbies = require('../hobbies');
describe("API unit test suite", () => {
    describe("getHobbies", () => {
        const list = hobbies.getHobbies();
        it("returns 5 hobbies", () => {
            expect(list.length).toEqual(5);
        });
        it("returns 'jogging' as first hobby", () => {
            expect(list[0]).toBe("jogging");
        });
    })
})
The last step is to add a support/jasmine.json file to configure our test framework, Jasmine. Add the following code snippet:
Copy
{
    "spec_dir": "spec",
    "spec_files": [
      "**/*[sS]pec.js"
    ],
    "stopSpecOnExpectationFailure": false,
    "random": false
}
This is all the code that we need for the moment.

We can now start to build the CI/CD pipeline:

Commit the code just created locally with the following command:
Copy
$ git add -A && git commit -m "First commit"
To avoid all of the node modules being saved to GitHub, add a .gitignore file to the project root folder with the following content:
Copy
node_modules
Now, we need to define a repository on GitHub. Log in to your account on GitHub at https://github.com.
Create a new repository there and call it jenkins-pipeline:


Create a new GitHub repository for the Jenkins pipeline sample application
Note that my GitHub account is gnschenker. In your case, it will be your own account.
After you have clicked the green button, Create repository, go back to you project and execute the following two commands from within the project root folder:
Copy
$ git remote add origin https://github.com/gnschenker/jenkins-pipeline.git
$ git push -u origin master
Make sure you replace gnschenker in the first line with your own GitHub account name. After this step, your code will be available on GitHub for further use. One of the users will be Jenkins, which will pull the code from this repository as we will show shortly.

The next thing is to go back to Jenkins (localhost:8080) and modify the configuration of the project. Log in to Jenkins if needed and select your project, sample-pipeline.
Then, select Configure in the main menu. Select the Pipeline tab and modify the settings so that they look similar to this:


Configuring Jenkins to pull source from GitHub
With this, we configure Jenkins to pull code from GitHub and use a Jenkinsfile to define the pipeline. Jenkinsfile is expected to be found in the root of the project. Note that for the repository URL path, we need to give the relative path to the /home directory where our project is located. Remember that, when running the Jenkins container, we mapped our own home folder on the host to the /home folder inside the Jenkins container with this: -v "$HOME":/home.

Hit the green Save button to accept the changes.
We have defined that Jenkinsfile needs to be in the project root folder. This is the foundation of Pipeline-as-Code, since the pipeline definition file will be committed to the GitHub repository along with the rest of the code. Hence, add a file called Jenkinsfile to the jenkins-pipeline folder and add this code to it:
Copy
pipeline {
    environment {
        registry = "gnschenker/jenkins-docker-test"
        DOCKER_PWD = credentials('docker-login-pwd')
    }
    agent {
        docker {
            image 'gnschenker/node-docker'
            args '-p 3000:3000'
            args '-w /app'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage("Build"){
            steps {
                sh 'npm install'
            }
        }
        stage("Test"){
            steps {
                sh 'npm test'
            }
        }
        stage("Build & Push Docker image") {
            steps {
                sh 'docker image build -t $registry:$BUILD_NUMBER .'
                sh 'docker login -u gnschenker -p $DOCKER_PWD'
                sh 'docker image push $registry:$BUILD_NUMBER'
                sh "docker image rm $registry:$BUILD_NUMBER"
            }
        }
    }
}
OK, let's dive into this file one part at a time. At the top, we're defining two environment variables that will be available throughout every stage of the pipeline. We will be using those variables in the Build & Push Docker image stage:

Copy
environment {
    registry = "gnschenker/jenkins-docker-test"
    DOCKER_PWD = credentials('docker-login-pwd')
}
The first variable, registry, just contains the full name of the container image we will eventually produce and push to Docker Hub. Replace gnschenker with your own GitHub username. The second variable, DOCKER_PWD, is a bit more interesting. It will contain the password to log in to my Docker Hub account. Of course, I don't want to have the value hardcoded here in code, hence, I use the credentials function of Jenkins that gives me access to a secret stored under the name docker-login-pwd in Jenkins. 

Next, we define the agent we want to use to run the Jenkins pipeline on. In our case, it is based on a Docker image. We are using the gnschenker/node-docker image for this purpose. This is an image based on node:12.10-alpine, which has Docker and curl installed, as we will need these two tools in some of the stages:

Copy
agent {
    docker {
        image 'gnschenker/node-docker'
        args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
}
With the args parameter, we are also mapping the Docker socket into the container so that we can use Docker from within the agent. 

Ignore the options part for the moment. We then are defining three stages:

Copy
stages {
    stage("Build"){
        steps {
            sh 'npm install'
        }
    }
    stage("Test"){
        steps {
            sh 'npm test'
        }
    }
    stage("Build & Push Docker image") {
        steps {
            sh 'docker image build -t $registry:$BUILD_NUMBER .'
            sh 'docker login -u gnschenker -p $DOCKER_PWD'
            sh 'docker image push $registry:$BUILD_NUMBER'
            sh "docker image rm $registry:$BUILD_NUMBER"
        }
    }
}
The first stage, Build, just runs npm install to make sure all external dependencies of our app can be installed. If this were, for example, a Java application, we would probably also compile and package the application in this step.

In the second stage, Test, we run npm test, which runs our unit tests that we have defined for the sample API.

The third stage, Build & Push Docker image, is a bit more interesting. Now that we have successfully built and tested our application, we can create a Docker image for it and push it to a registry. We are using Docker Hub as our registry, but any private or public registry would work. In this stage, we define four steps:

We use Docker to build the image. We use the $registry environment variable we have defined in the first part of the Jenkinsfile. The $BUILD_NUMBER variable is defined by Jenkins itself.
Before we can push something to the registry, we need to log in. Here, I am using the $DOCKER_PWD variable that I defined earlier on.
Once we're successfully logged in to the registry, we can push the image.
Since the image is now in the registry, we can delete it from the local cache to avoid wasting space.
Remember that all of the stages run inside our gnschenker/node-docker builder container. Hence, we're running Docker inside Docker. But, since we have mapped the Docker socket into the builder, the Docker commands act on the host.

Let's add two more stages to the pipeline. The first one looks like this:

Copy
stage('Deploy and smoke test') {
    steps{
        sh './jenkins/scripts/deploy.sh'
    }
}
Add it just after the Build & Push Docker image stage. This stage just executes a deploy.sh script located in the jenkins/scripts subfolder. We do not yet have such a file in our project.

Hence, add this file to your project with the following content:

Copy
#!/usr/bin/env sh

echo "Removing api container if it exists..."
docker container rm -f api || true
echo "Removing network test-net if it exists..."
docker network rm test-net || true

echo "Deploying app ($registry:$BUILD_NUMBER)..."
docker network create test-net

docker container run -d \
    --name api \
    --net test-net \
    $registry:$BUILD_NUMBER

# Logic to wait for the api component to be ready on port 3000

read -d '' wait_for << EOF
echo "Waiting for API to listen on port 3000..."
while ! nc -z api 3000; do 
  sleep 0.1 # wait for 1/10 of the second before check again
  printf "."
done
echo "API ready on port 3000!"
EOF

docker container run --rm \
    --net test-net \
    node:12.10-alpine sh -c "$wait_for"

echo "Smoke tests..."
docker container run --name tester \
    --rm \
    --net test-net \
    gnschenker/node-docker sh -c "curl api:3000"
OK, so this code does the following. First, it tries to remove any artifacts that might have been left over from an earlier, failed run of the pipeline. Then, it creates a Docker network called test-net. Next, it runs a container from the image we built in the previous step. This container is our Express JS API and is called api accordingly.

This container and the application within it may take a moment to be ready. Hence, we define some logic that uses the netcat or nc tool to probe port 3000. Once the application is listening at port 3000, we continue with the smoke test. In our case, the smoke test is just making sure it can access the / endpoint of our API. We are using curl for this task. In a more realistic setup, you would run some more sophisticated tests here.

As a last stage, we are adding a Cleanup step:

Add the following snippet as a last stage to your Jenkinsfile:
Copy
stage('Cleanup') {
    steps{
        sh './jenkins/scripts/cleanup.sh'
    }
}
Once again, this Cleanup stage uses a script located in the jenkins/script subfolder.

Please add such a file to your project with the following content:
Copy
#!/usr/bin/env sh

docker rm -f api
docker network rm test-net
This script removes the api container and the Docker network, test-net, that we used to run our containers on.

Now, we are ready to roll. Use git to commit your changes and push them to your repository:
Copy
$ git -a . && git commit -m "Defined code based Pipeline"
$ git push origin master
Once the code is pushed to GitHub, go back to Jenkins.

Select your sample-pipeline project and click Build now in the main menu. Jenkins will start to build the pipeline. If everything goes well, you should see something like this:


Running our full code-based pipeline in Jenkins
Our pipeline is executed successfully and now has six steps. The checkout from GitHub has been automatically added as a first enabling step. To access the logs generated during the pipeline execution, you can click the little ball icon on the left side of the run under Build History. In the preceding screenshot, it is the bluish icon on the left of #26. This is especially helpful if the pipeline step fails to quickly find the root cause of the failure.

To summarize, we have built a simple CI/CD pipeline where everything, including the automation server, Jenkins, is running in containers. We have only scratched the surface of what is possible.