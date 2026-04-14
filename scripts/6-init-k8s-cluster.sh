#!/bin/bash
set -e

echo "=== Step 6: Initialize Kubernetes Cluster ==="

echo "Installing bridge utilities..."
sudo apt-get install -y bridge-utils

echo "Loading required kernel modules..."
sudo modprobe br_netfilter || true

echo "Setting kernel parameters..."
echo "1" | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables > /dev/null || true
echo "1" | sudo tee /proc/sys/net/bridge/bridge-nf-call-ip6tables > /dev/null || true

echo "Initializing Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=FileContent--proc-sys-net-bridge-bridge-nf-call-iptables

echo "=== Kubernetes cluster initialized ==="
echo ""
echo "=== Save this join command for adding more nodes later ==="
echo " kubeadm join <MASTER-IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>"
echo ""