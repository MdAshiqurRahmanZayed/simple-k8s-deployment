#!/bin/bash
set -e

echo "=== Step 7: Configure kubectl for Current User ==="

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "=== kubectl configured successfully ==="
kubectl get nodes