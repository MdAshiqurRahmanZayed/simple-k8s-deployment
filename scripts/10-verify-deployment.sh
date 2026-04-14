#!/bin/bash
set -e

echo "=== Verify Kubernetes Deployment ==="

echo ""
echo "=== Namespace ==="
kubectl get namespace production

echo ""
echo "=== Nodes ==="
kubectl get nodes -o wide

echo ""
echo "=== All Pods ==="
kubectl get pods --all-namespaces

echo ""
echo "=== Production Namespace Pods ==="
kubectl get pods -n production -o wide

echo ""
echo "=== Production Namespace Services ==="
kubectl get svc -n production

echo ""
echo "=== Production Namespace Deployments ==="
kubectl get deployment -n production

echo ""
echo "=== Describe Deployment ==="
kubectl describe deployment -n production

echo ""
echo "=== Application Access ==="
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
if [ -z "$NODE_IP" ]; then
    NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
fi
echo "Application URL: http://${NODE_IP}:30002"