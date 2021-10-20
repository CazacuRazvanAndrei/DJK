# Using Docker to power a CI/CD pipeline
The goal of this section is to build a CI/CD pipeline that looks like this:



A simple CI/CD pipeline using Jenkins
We are going to use Jenkins (https://jenkins.io) as our automation server. Other automation servers such as TeamCity (https://www.jetbrains.com/teamcity) work equally well. When using Jenkins, the central document is the Jenkinsfile, which will contain the definition of the pipeline with its multiple stages.

A simple Jenkinsfile with the Build, Test, Deploy to Staging, and Deploy to Production stages could look like this:

```
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
```
Of course, the preceding pipeline just outputs a message during each stage and does nothing else. It is useful though as a starting point from which to build up our pipeline:
