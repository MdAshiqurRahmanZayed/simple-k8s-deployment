#!/bin/bash
set -e

echo "=== Step 4: Install kubectl, kubeadm, kubelet ==="

KUBERNETES_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | cut -d '+' -f1)

echo "Installing Kubernetes version: ${KUBERNETES_VERSION}"

sudo apt-get update
sudo apt-get install -y kubelet=${KUBERNETES_VERSION}-* kubeadm=${KUBERNETES_VERSION}-* kubectl=${KUBERNETES_VERSION}-*
sudo apt-mark hold kubelet kubeadm kubectl

echo "=== Kubernetes tools installed successfully ==="
kubeadm version
kubectl version --client