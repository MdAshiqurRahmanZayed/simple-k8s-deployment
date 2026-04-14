#!/bin/bash
set -e

echo "=== Step 6: Initialize Kubernetes Cluster ==="

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

echo "=== Kubernetes cluster initialized ==="
echo ""
echo "=== Save this join command for adding more nodes later ==="
echo " kubeadm join <MASTER-IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>"
echo ""