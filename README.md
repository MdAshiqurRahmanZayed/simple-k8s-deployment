# Kubernetes Deployment for Assignment 11

## Overview
This project contains scripts and manifests to deploy a containerized application on Kubernetes.

## Application Details
- **Image:** `mdzayed/assignment_10_ostad_devops:v4`
- **Container Port:** 5000
- **External Port:** 30002
- **Replicas:** 2

## Project Structure

```
simple-deploymen-k8s/
├── scripts/
│   ├── 1-update-system-and-install-dependencies.sh
│   ├── 2-disable-swap.sh
│   ├── 3-add-kubernetes-repo.sh
│   ├── 4-install-k8s-tools.sh
│   ├── 5-configure-docker-cgroup.sh
│   ├── 6-init-k8s-cluster.sh
│   ├── 7-configure-kubectl.sh
│   ├── 8-install-pod-network.sh
│   ├── 9-deploy-app.sh
│   └── 10-verify-deployment.sh
├── manifests/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/
│   └── (AWS infrastructure code)
└── ssh/
    └── (SSH keys)
```

## Prerequisites
- AWS EC2 t3.medium instance (Ubuntu 20.04+)
- SSH access to the instance
- Docker Hub account with pushed image

## Installation Steps

### Phase 1: Kubernetes Setup (Run on EC2)

Execute scripts in order:

```bash
# Script 1: Update system and install dependencies
chmod +x 1-update-system-and-install-dependencies.sh
./1-update-system-and-install-dependencies.sh

# Script 2: Disable swap
chmod +x 2-disable-swap.sh
./2-disable-swap.sh

# Script 3: Add Kubernetes repository
chmod +x 3-add-kubernetes-repo.sh
./3-add-kubernetes-repo.sh

# Script 4: Install kubectl, kubeadm, kubelet
chmod +x 4-install-k8s-tools.sh
./4-install-k8s-tools.sh

# Script 5: Configure Docker cgroup driver
chmod +x 5-configure-docker-cgroup.sh
./5-configure-docker-cgroup.sh

# Script 6: Initialize Kubernetes cluster
chmod +x 6-init-k8s-cluster.sh
./6-init-k8s-cluster.sh

# Script 7: Configure kubectl
chmod +x 7-configure-kubectl.sh
./7-configure-kubectl.sh

# Script 8: Install Calico Pod Network
chmod +x 8-install-pod-network.sh
./8-install-pod-network.sh
```

### Phase 2: Deploy Application

```bash
# Script 9: Deploy application
chmod +x 9-deploy-app.sh
./9-deploy-app.sh

# Script 10: Verify deployment
chmod +x 10-verify-deployment.sh
./10-verify-deployment.sh
```

## Manifest Files

### namespace.yaml
Creates the `production` namespace.

### deployment.yaml
Deploys the application with:
- 2 replicas
- Resource limits (256Mi RAM, 250m CPU)
- Health checks (liveness and readiness probes)

### service.yaml
Exposes the application via NodePort on port 30002.

## Access the Application

After successful deployment:
```
http://<EC2-PUBLIC-IP>:30002
```

## Verification Commands

```bash
# Check nodes
kubectl get nodes

# Check pods in production namespace
kubectl get pods -n production

# Check services
kubectl get svc -n production

# Check deployment
kubectl get deployment -n production

# View logs
kubectl logs -n production -l app=ostad-devops

# Describe pod
kubectl describe pod <pod-name> -n production
```

## Clean Up

```bash
kubectl delete namespace production
```

## Troubleshooting

### Pods not running
```bash
kubectl describe pod <pod-name> -n production
kubectl logs <pod-name> -n production
```

### Node not ready
```bash
kubectl describe node <node-name>
```

### Service not accessible
```bash
kubectl get svc -n production
# Check if nodePort 30002 is open in security group
```
