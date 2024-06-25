#!/bin/bash

set -e

# 脚本头部注释
cat << EOF
This script will uninstall Minikube, kubectl, and optionally conntrack.
It will remove all associated data and configurations.
Use this script with caution as data loss is irreversible.
EOF

# 确认是否继续
read -p "Are you sure you want to continue? (y/N): " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || exit 1

echo "Stopping Minikube..."
minikube stop || { echo "Failed to stop Minikube."; exit 1; }

echo "Deleting Minikube VM and all associated files..."
minikube delete --all --purge || { echo "Failed to delete Minikube data."; exit 1; }

echo "Removing Minikube executable..."
sudo rm -f /usr/local/bin/minikube || { echo "Failed to remove Minikube executable."; exit 1; }

echo "Removing kubectl executable..."
sudo rm -f /usr/local/bin/kubectl || { echo "Failed to remove kubectl executable."; exit 1; }

echo "Cleaning up leftover files..."
sudo rm -rf ~/.minikube || { echo "Failed to remove .minikube directory."; exit 1; }
sudo rm -rf ~/.kube || { echo "Failed to remove .kube directory."; exit 1; }

echo "Minikube and associated tools have been uninstalled successfully."
