#!/bin/bash
set -e

echo "=== Step 2: Disable Swap (Required for Kubernetes) ==="

sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab

echo "=== Swap disabled successfully ==="