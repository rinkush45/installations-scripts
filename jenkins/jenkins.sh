#!/usr/bin/env bash
set -euo pipefail

# Jenkins installation script for Ubuntu/Debian
echo "Installing Jenkins on Ubuntu/Debian..."

# Install Java
sudo apt-get update
sudo apt-get install -y fontconfig openjdk-21-jre
java -version

# Add Jenkins repository and key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Start and enable Jenkins service
sudo systemctl enable --now jenkins
sudo systemctl status jenkins --no-pager

# Open firewall port
sudo ufw allow 8080/tcp
sudo ufw reload

# Display initial admin password
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Jenkins installation complete. Access at http://your_server_ip:8080"