# This repository demonstrates how to set up Kaniko on EKS to build and push Docker images to a private Docker Hub repository. The workflow leverages GitHub Actions to automate the build and deployment process using Kubernetes.

## Step 1: Use the provided kaniko-sa.yaml to create a Kubernetes service account for Kaniko.
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kaniko
  namespace: default
```
### Apply the configuration:

  ```bash
  kubectl apply -f k8-service-account/kaniko-sa.yaml
  ```

## Step 2: Generate a Kubernetes secret to authenticate with your private Docker repository.
```bash
kubectl create secret docker-registry regcred \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=${DOCKER_USERNAME} \
    --docker-password=${DOCKER_PASSWORD}
```
# How to use the repository
## 1. Fork or clone the github repo. The repository contains the build-and-push.yaml GitHub Actions workflow file, which executes the Kaniko job in your Kubernetes cluster to build and push Docker images.

## 2. In kaniko-job.yaml, update the GitHub URL to point to your application’s source code repository.

## 3.Ensure that your GitHub repository is configured with the required secrets for AWS credentials. These are necessary for the workflow to execute successfully.


## This setup will allow you to automate Docker image builds and push them to Docker Hub using Kaniko in an EKS environment.
