#!/bin/bash
set -e

echo "=== Step 4: Install kubectl, kubeadm, kubelet ==="

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "=== Kubernetes tools installed successfully ==="
kubeadm version
kubectl version --client