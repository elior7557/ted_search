# TED Search Application
The TED Search Application is a search engine for TED Talks, it's built using a combination of CI/CD, Docker Compose, and Terraform files. This repository contains the code and configurations necessary to set up and deploy the application.


# CI/CD
The application uses Jenkins for continuous integration and deployment.
 A Jenkins pipeline is defined that runs unit tests, builds the application's Docker image, and deploys it to the test environment for e2e tests. 
 The pipeline is triggered automatically when changes are pushed to the each branch.
 
 # Docker Compose
 The application uses Docker Compose to define and run the application's services. A docker-compose.yml file is included in the repository that describes the services needed to run the application.
 Nginx to serve the static files.
 And Jre Image for The RunTime.

 # Terraform

The application is deployed to the test and production environments using Terraform. The Terraform files in the terraform directory are used to provision the necessary infrastructure, such as vpc, public subnet and to deploy the application's Docker containers.
