#!/bin/bash
set -e

echo "=== Fix Unstable Kubernetes Cluster ==="

echo "Step 1: Reset existing cluster"
sudo kubeadm reset -f || true
sudo rm -rf /etc/kubernetes /var/lib/kubelet /var/lib/etcd

echo "Step 2: Clean up Docker"
sudo docker system prune -af || true

echo "Step 3: Restart Docker"
sudo systemctl restart docker

echo "Step 4: Initialize cluster fresh"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=FileContent--proc-sys-net-bridge-bridge-nf-call-iptables

echo "Step 5: Configure kubectl"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Step 6: Remove control-plane taint (for single-node)"
kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule- || true

echo "Step 7: Install Calico CNI"
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "Step 8: Wait for cluster to stabilize"
sleep 60

echo "Step 9: Check cluster status"
kubectl get nodes
kubectl get pods -n kube-system

echo "=== Cluster ready! ==="