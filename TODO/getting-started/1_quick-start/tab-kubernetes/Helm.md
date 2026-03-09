
# Helm Setup for Kubernetes

Helm helps you manage Kubernetes applications.

## Prerequisites

- Kubernetes cluster is set up.
- Helm is installed.

## Steps

1. **Add Sage.is AI-UI Helm Repository:**

   ```bash
   helm repo add sage-is-ai-ui https://sage-is-ai-ui.github.io/helm-charts
   helm repo update
   ```

2. **Install Sage.is AI-UI Chart:**

   ```bash
   helm install Sage.is AI-UI sage-is-ai-ui/sage-is-ai-ui
   ```

3. **Verify Installation:**

   ```bash
   kubectl get pods
   ```

## Access the Sage.is AI-UI

Set up port forwarding or load balancing to access Sage.is AI-UI from outside the cluster.
