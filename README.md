# 🚀 Brain Tasks App – End-to-End DevOps Deployment (Docker + EKS + CI/CD)

This project demonstrates a **complete DevOps pipeline** for deploying a static web application using:

* Docker (containerization)
* AWS ECR (image registry)
* AWS EKS (Kubernetes cluster)
* AWS CodeBuild (build & deploy automation)
* AWS CodePipeline (CI/CD orchestration)
* Helm (Kubernetes package manager)
* CloudWatch (logs & monitoring)

---

# 📦 Project Overview

This repository contains the **production-ready build (`dist/`)** of the Brain Tasks App.

Since this is already compiled:

* ❌ No Node.js build required
* ❌ No dependencies required
* ✅ Served using Nginx

* The production ready code was available in locally. In this directory, CMD was accessed to create a helm chart. 
* Dockerfile was created to host the application on NGINX and expose it on port 3000.
* The deployment and service manifests' YAML was written for efficient management and code reusability.
* ECR was created on AWS for uploading the artifacts built via AWS CodeBuild.
* CodeBuild project for building artifact is created and buildspec.yml is written and pushed to GitHub repo. The build was then triggered to see if this stage works properly.
* EKS cluster was provisioned using eksctl command.
* Since, CodeDeploy doesn't have native Kubernetes deployment support, another CodeBuild project was created to install kubectl and helm for deploying the manifest files on the EKS cluster. The buildspec-deploy.yml is pushed to Git repo and the same name is specified in the project configuration. IAM policies with explicit access to EKS cluster must attached to this CodeBuild project role. EKS authentication requires both IAM + aws-auth mapping
* Now, CodePipeline is created with Source Stage connected to GitHub app, Build stage for CodeBuild project for building artifacts & an additional Build Stage for the other CodeBuild project to deploy the artifacts. This was executed and completed succesfully.
* We retrieved the LoadBalancer service and use the external IP to access our application.

---

# 🧱 Architecture

```
GitHub (Source)
   ↓
CodePipeline
   ↓
CodeBuild (Build Stage)
   ↓
Amazon ECR
   ↓
CodeBuild (Deploy Stage)
   ↓
Amazon EKS (Helm Deployment)
   ↓
LoadBalancer Service (Public Access)
```

---

# 📁 Repository Structure

```
Brain-Tasks-App/
│
├── dist/                     # Production build files
├── Dockerfile                # Docker image definition
├── buildspec.yml             # Build stage (Docker → ECR)
├── buildspec-deploy.yml      # Deploy stage (Helm → EKS)
└── brain-tasks-app/          # Helm chart
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
```

# 🌐 Access Application

```bash
kubectl get svc
```

👉 Use **EXTERNAL-IP** to access the app

---