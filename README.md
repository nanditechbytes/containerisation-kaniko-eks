# This repository demonstrates how to set up Kaniko on EKS to build and push Docker images to a private Docker Hub repository. 

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
  kubectl apply -f kaniko-sa.yaml
  ```

## Step 2: Generate a Kubernetes secret to authenticate with your private Docker repository.
```bash
kubectl create secret docker-registry regcred \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=${DOCKER_USERNAME} \
    --docker-password=${DOCKER_PASSWORD}
```


## 3. In kaniko-job.yaml, update the GitHub URL to point to your application’s source code repository.



## 4. Run the kaniko job with below command which will build and push your docker image

```bash
kubectl apply -f kaniko-job.yaml
```
