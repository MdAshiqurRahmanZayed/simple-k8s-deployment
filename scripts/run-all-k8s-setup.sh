#!/bin/bash
set -e

echo "=========================================="
echo "Running All Kubernetes Setup Scripts"
echo "=========================================="

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for i in {1..8}; do
    script="${SCRIPTS_DIR}/${i}-"*.sh
    if [ -f "$script" ]; then
        echo ""
        echo "=== Running $(basename $script) ==="
        echo ""
        bash "$script"
        echo ""
    fi
done

echo "=========================================="
echo "All K8s setup scripts completed!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Run: ./9-deploy-app.sh"
echo "2. Run: ./10-verify-deployment.sh"