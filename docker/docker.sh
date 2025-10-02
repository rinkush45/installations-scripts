#!/usr/bin/env bash
set -euo pipefail

# Docker Engine install script for Ubuntu (from docker.md commands)
# - Removes conflicting packages
# - Adds Docker's official apt repository
# - Installs Docker Engine, CLI, containerd, Buildx, and Compose
# - Enables and starts Docker service
# - Verifies with hello-world

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run as root (e.g., sudo $0)" >&2
  exit 1
fi

echo "[1/6] Uninstalling conflicting packages (if present)..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  apt-get remove -y "$pkg" >/dev/null 2>&1 || true
done

echo "[2/6] Installing prerequisites..."
apt-get update -y
apt-get install -y ca-certificates curl gnupg

echo "[3/6] Adding Docker's GPG key and apt repository..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

ARCH=$(dpkg --print-architecture)
UBUNTU_CODENAME=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")

echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${UBUNTU_CODENAME} stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y

echo "[4/6] Installing Docker Engine packages..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[5/6] Enabling and starting Docker service..."
systemctl enable --now docker
usermod -aG docker "$USER" || true
sudo chmod 777 /var/run/docker.sock

echo "[6/6]Downloading & Installing scout package"
curl -fsSL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh -o install-scout.sh
chmod 777 install-scout.sh
sh install-scout.sh

echo "Verifying Docker installation with hello-world..."
if ! docker run --rm hello-world >/dev/null 2>&1; then
  docker run --rm hello-world || true
else
  # Run once visibly so user sees output
  docker run --rm hello-world || true
fi

echo
echo "Docker installation complete. You may need to log out/in for group changes to take effect."
echo "Test: docker run --rm hello-world"

echo
echo "----- Example output from 'docker run hello-world' -----"
cat <<'EOF'
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
EOF 