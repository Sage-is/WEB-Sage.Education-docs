
# Kustomize Setup for Kubernetes

Kustomize allows you to customize Kubernetes YAML configurations.

## Prerequisites

- Kubernetes cluster is set up.
- Kustomize is installed.

## Steps

1. **Clone the Sage.is AI-UI Manifests:**

   ```bash
   git clone https://github.com/Startr/k8s-manifests.git
   cd k8s-manifests
   ```

2. **Apply the Manifests:**

   ```bash
   kubectl apply -k .
   ```

3. **Verify Installation:**

   ```bash
   kubectl get pods
   ```

## Access the WebUI

Set up port forwarding or load balancing to access Sage.is AI-UI from outside the cluster.
