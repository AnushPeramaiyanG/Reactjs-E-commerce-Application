🚀 React Application – DevOps CI/CD Project

A complete DevOps project demonstrating the deployment, containerization,
CI/CD automation, Docker Hub image management, AWS EC2 deployment,
automated application deployment, and open-source monitoring of a React
application.
---

📌 Project Overview

This project implements a production-oriented DevOps workflow for deploying
a React application using:

- GitHub
- Git
- Docker
- Docker Compose
- Bash scripting
- Docker Hub
- Jenkins
- AWS EC2
- Ubuntu
- Prometheus
- Grafana
- Alertmanager
---

The project supports separate DEV and PROD Docker image repositories.

📁 Repository Structure
Reactjsapp/devops-build/
│
├── src/
├── public/
├── Dockerfile
├── docker-compose.yml
├── build.sh
├── deploy.sh
├── Jenkinsfile
├── .dockerignore
├── .gitignore
└── README.md
---

🛠️ Technologies Used

Git	  -  Version control
GitHub  -  	Source code management
Docker  -  	Containerization
Docker Compose  -  	Application deployment
Bash  -  	Automation scripts
Docker Hub  -  	Container image registry
Jenkins  -  	CI/CD automation
AWS  -  EC2	Cloud infrastructure
Ubuntu  -  	Server operating system
Prometheus  -  	Monitoring
Grafana  - 	Monitoring dashboard
Alertmanager  -  	Down notifications
---

🌿 Git Branch Strategy

DEV
dev
 |
 v
Jenkins
 |
 v
Docker Build
 |
 v
Docker Hub DEV

PROD
dev
 |
 | merge
 v
master
 |
 v
Jenkins
 |
 v
Docker Build
 |
 v
Docker Hub PROD
---

🐳 Docker

The application is containerized using a multi-stage Docker build.

The production container serves the React application using Nginx.

Application port:80

📦 Docker Compose

Docker Compose is used to run the application container.

docker compose up -d

Stop:
docker compose down
---

📜 Bash Scripts
build.sh

Responsible for:
Building Docker images
Applying the required image tag

Execute:
./build.sh

deploy.sh

Responsible for:
Pulling the latest Docker image
Restarting the application
Validating application availability

Execute:
./deploy.sh
---

🔄 CI/CD Pipeline

DEV Pipeline
Developer
   |
git push origin dev
   |
GitHub
   |
Webhook
   |
Jenkins
   |
Docker Build
   |
Docker Hub DEV
   |
Application Server
   |
Deployment


PROD Pipeline
DEV
 |
 | Merge
 v
master
 |
git push
 |
GitHub
 |
Jenkins
 |
Docker Build
 |
Docker Hub PROD
 |
Application Server
 |
Deployment
---

🔐 Docker Hub

Two Docker Hub repositories are used.

DEV
anushperamaiyang/devops-build-dev
Visibility: Public

PROD
anushperamaiyang/devops-build-prod
Visibility: Private
---

☁️ AWS Infrastructure

The project uses AWS EC2 Ubuntu instances.

Application Server
Responsibilities:
Docker
Docker Compose
React application
Node Exporter

Application: http://ec2-3-109-3-255.ap-south-1.compute.amazonaws.com/

Jenkins Server
Responsibilities:
Jenkins
Docker
Git
CI/CD pipeline

Monitoring Server
Responsibilities:
Prometheus
Grafana
Alertmanager
---

🔒 Security Group

Application Server:
Service	Port	Source
SSH	22	My IP / Jenkins SG
HTTP	80	0.0.0.0/0

Jenkins:
Service	Port	Source
SSH	22	My IP
Jenkins	8080	My IP
---

📊 Monitoring
Open-source monitoring is implemented using:
Prometheus
Node Exporter
Grafana
Alertmanager

Prometheus monitors:
Application availability
Server health
CPU
Memory
Disk
Network
---

🚨 Application Down Alert

The application health is monitored using Prometheus.

When the application becomes unavailable:

Application
     |
     X
     |
Prometheus
     |
ApplicationDown
     |
Alertmanager

Notifications are generated only when the application is down.
---

🧪 Health Check

Application:
curl -I http://localhost

Expected:
HTTP/1.1 200 OK

Docker:
docker ps

Prometheus:
application → UP
---


🏗️ Architecture

GitHub
   |
   | Webhook
   v
Jenkins
   |
   +-----------------------+
   |                       |
 dev branch            master branch
   |                       |
   v                       v
Docker Build           Docker Build
   |                       |
   v                       v
Docker Hub DEV        Docker Hub PROD
 Public Repository     Private Repository
   |                       |
   +-----------+-----------+
               |
               v
       AWS Application EC2
               |
          Docker Compose
               |
               v
       React Application
           HTTP :80
               |
          Node Exporter
               |
               v
          Prometheus
               |
               v
         Alertmanager

Grafana
   |
   +--> Monitoring Dashboard
---   
