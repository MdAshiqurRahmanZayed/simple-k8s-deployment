#!/bin/bash
set -e

echo "=== Step 8: Install Calico Pod Network ==="

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "=== Calico CNI installed successfully ==="
echo "=== Waiting for pods to be ready ==="
sleep 10
kubectl get pods --all-namespaces