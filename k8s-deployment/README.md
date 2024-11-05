## README.md for k8s-deployment

This README.md file provides a guide to deploying a Kubernetes cluster using eksctl.

### Prerequisites

1. **eksctl**: Ensure eksctl is installed on your machine. You can install it using the following command:

    ```bash
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    ```

### Authentication and Deployment Steps

1. **Configure kubectl for your EKS cluster**:
    ```bash
    aws eks update-kubeconfig --name your-cluster-name --region your-region
    ```

2. **Create manifests directory**:
    ```bash
    mkdir manifests
    ``` 

4. **Deploy the manifests**:
    ```bash
    kubectl apply -f manifests/
    ```

5. **Verify the deployment**:
    ```bash
    kubectl get pods
    kubectl get hpa
    kubectl get svc
    ```

6. **Get the LoadBalancer URL**:
    ```bash
    kubectl get svc app-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
    ```

Note: Replace `ACCOUNT_ID`, `REGION`, `your-repo`, and `tag` in the deployment manifest with your actual AWS ECR repository details.
