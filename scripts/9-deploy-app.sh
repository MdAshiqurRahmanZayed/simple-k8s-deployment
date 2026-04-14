#!/bin/bash
set -e

echo "=== Deploy Application to Kubernetes ==="

echo "=== Applying namespace ==="
kubectl apply -f ../manifests/namespace.yaml

echo "=== Applying deployment ==="
kubectl apply -f ../manifests/deployment.yaml

echo "=== Applying service ==="
kubectl apply -f ../manifests/service.yaml

echo ""
echo "=== Deployment complete ==="
echo ""
echo "=== Checking status ==="
kubectl get pods -n production
kubectl get svc -n production
kubectl get deployment -n production

echo ""
echo "=== To access the application ==="
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
if [ -z "$NODE_IP" ]; then
    NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
fi
echo "Access the application at: http://${NODE_IP}:30002"