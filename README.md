# DevOps Task – CI/CD Pipeline with Jenkins, Docker, AWS ECS

## Architecture Diagram
![Architecture](https://github.com/user-attachments/assets/30d6fcdc-772a-4287-8b97-cc09dd39cd42)

---

## Setup Instructions

### 1. Clone Repository
   bash
git clone https://github.com/nanapurvenu/devops-task.git
cd devops-task

### 2. Build Docker Image Locally
 docker build -t <venureddy3417/devops-task:v16 .
 docker run -p 3000:3000 venureddy3417/devops-task:v16

### 3. Jenkins Setup

Install plugins:
1) Git

2) NodeJS

3) Docker

4) Pipeline

5) Configure:

6) NodeJS tool (NodeJS-20)

7) DockerHub credentials

8) AWS credentials

### 4. AWS Setup

ECS Cluster: devops-task-app

ECS Service: devops-task-service

ALB + Target group already created via Terraform.

### Pipeline Flow

Checkout Code → Fetch from GitHub repo.

Install Dependencies → npm install.

Run Tests → (Skipped since no tests configured).

Build Docker Image → Builds & tags image with commit version.

Push Docker Image → Push to DockerHub.

Deploy to ECS → Runs aws ecs update-service to trigger new deployment.
