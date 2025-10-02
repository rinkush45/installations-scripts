#!/bin/bash

# Trivy Installation Script for Ubuntu/Debian
# This script installs Trivy vulnerability scanner

set -e  # Exit on any error

echo "🔧 Installing Trivy vulnerability scanner..."

# Install prerequisites
echo "📦 Installing prerequisites..."
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

# Add Trivy GPG key
echo "🔑 Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

# Add Trivy repository
echo "📋 Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Update package list
echo "🔄 Updating package list..."
sudo apt-get update

# Install Trivy
echo "⬇️ Installing Trivy..."
sudo apt-get install trivy -y

# Verify installation
echo "✅ Verifying installation..."
trivy version

echo "🎉 Trivy installation completed successfully!"
echo "💡 Usage: trivy image <image-name>"