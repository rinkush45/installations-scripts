# Trivy Installation (Ubuntu / Debian)

## Prerequisites

- Ubuntu/Debian system with sudo access
- Internet connection for downloading packages

---

## Installation Methods

### Method 1: APT Repository (Recommended)

```bash
# Add Trivy repository
sudo apt-get update
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Install Trivy
sudo apt-get update
sudo apt-get install trivy
```

### Method 2: Binary Download

```bash
# Download and install latest binary
VERSION=$(curl -s "https://api.github.com/repos/aquasecurity/trivy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
wget https://github.com/aquasecurity/trivy/releases/download/${VERSION}/trivy_${VERSION#v}_Linux-64bit.tar.gz
tar zxvf trivy_${VERSION#v}_Linux-64bit.tar.gz
sudo mv trivy /usr/local/bin/
```

### Method 3: Snap Package

```bash
sudo snap install trivy
```

---

## Verification

```bash
# Check version
trivy version

# Test scan
trivy image hello-world
```

---

## Basic Usage

```bash
# Scan container image
trivy image nginx:latest

# Scan filesystem
trivy fs /path/to/project

# Scan repository
trivy repo https://github.com/user/repo

# Generate report in JSON format
trivy image --format json --output results.json nginx:latest
```

---

## Docker Usage

```bash
# Run Trivy in Docker
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:latest image nginx:latest
```

---

## ⚠️ Important Notes

- Trivy requires internet access to download vulnerability databases
- First scan may take longer as it downloads the database
- For offline usage, consider using `trivy image --cache-dir` option
- For CI/CD integration, use `--exit-code 1` to fail on vulnerabilities

---
## ⚠️ Important Alert
- If you encounter any issue please go through [official documentation](https://trivy.dev/)
- If you face any problem and help please contact the system admin/team lead