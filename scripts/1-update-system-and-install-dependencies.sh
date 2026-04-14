#!/bin/bash
set -e

echo "=== Step 1: Update System and Install Dependencies ==="

sudo apt update && sudo apt upgrade -y

sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release docker.io

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

echo "=== Dependencies installed successfully ==="