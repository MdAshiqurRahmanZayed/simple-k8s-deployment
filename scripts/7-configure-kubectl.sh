#!/bin/bash
set -e

echo "=== Step 7: Configure kubectl for Current User ==="

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "=== Checking control plane status ==="
echo "Waiting for API server to start..."
sleep 30

echo "=== Control plane pods ==="
sudo kubectl get pods -n kube-system

echo ""
echo "=== Testing kubectl connection ==="
kubectl get nodes --request-timeout=10s || echo "API server not ready yet"

echo "=== kubectl configured ==="