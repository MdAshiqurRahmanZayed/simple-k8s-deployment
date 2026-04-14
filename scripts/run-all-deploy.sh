#!/bin/bash
set -e

echo "=========================================="
echo "Running All Deployment Scripts"
echo "=========================================="

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for i in 9 10; do
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
echo "All deployment scripts completed!"
echo "=========================================="