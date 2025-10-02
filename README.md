# 🛠️ Installation Scripts

Automated setup scripts for essential DevOps tools.

---

## 🐳 docker/docker.sh

**What it does:**
- Removes conflicting Docker packages
- Installs Docker Engine, CLI, containerd, Buildx & Compose
- Configures Docker service and permissions
- Installs Docker Scout for security scanning
- Verifies installation with hello-world container

**When to use:**
- Setting up new development environments
- Preparing CI/CD build servers
- Container deployment infrastructure setup

**How it helps:**
Eliminates manual Docker installation steps and ensures consistent container environment across all systems.

---

## 📝 git/git.sh

**What it does:**
- Cross-platform Git installation (Ubuntu/Debian/macOS/Windows)
- Auto-detects operating system
- Installs Homebrew on macOS if needed
- Provides Windows PowerShell commands

**When to use:**
- New developer onboarding
- Setting up version control on fresh systems
- Standardizing Git across different OS environments

**How it helps:**
Streamlines Git setup across multiple platforms, reducing onboarding time and ensuring version control availability.

---

## 🏗️ jenkins/jenkins.sh

**What it does:**
- Installs Java 21 runtime
- Adds Jenkins official repository
- Installs and configures Jenkins service
- Opens firewall port 8080
- Displays initial admin password

**When to use:**
- Setting up CI/CD pipeline infrastructure
- Automating build and deployment processes
- Creating Jenkins build agents

**How it helps:**
Automates Jenkins setup for continuous integration, enabling automated testing and deployment workflows.

---

## 🔍 trivy/trivy.sh

**What it does:**
- Installs Trivy vulnerability scanner
- Adds Trivy GPG key and repository
- Configures security scanning capabilities
- Verifies installation

**When to use:**
- Implementing security scanning in CI/CD
- Container image vulnerability assessment
- Infrastructure as Code security checks

**How it helps:**
Enables automated security scanning for containers and code, ensuring vulnerabilities are detected early in the development cycle.
