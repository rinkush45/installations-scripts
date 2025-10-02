
# Jenkins installation (Ubuntu / Debian)

## Prerequisites

Minimum hardware requirements:

- 256 MB of RAM
- 1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

Recommended hardware configuration for a small team:

- 4 GB+ of RAM
- 50 GB+ of drive space

Comprehensive hardware recommendations:

- Hardware: see the Hardware Recommendations page

Software requirements:

- Java: see the [Java Requirements page](https://www.jenkins.io/doc/book/platform-information/support-policy-java/)
- Web browser: see the [Web Browser Compatibility page](https://www.jenkins.io/doc/book/platform-information/support-policy-web-browsers/)

Platform and servlet container policies:

- For Windows operating system: [Windows Support Policy](https://www.jenkins.io/doc/book/platform-information/support-policy-windows/)
- For Linux operating system: [Linux Support Policy](https://www.jenkins.io/doc/book/platform-information/support-policy-linux/)
- For servlet containers: [Servlet Container Support Policy](https://www.jenkins.io/doc/book/platform-information/support-policy-servlet-containers/)

---

Below are copyable commands and short descriptions to install Jenkins on Ubuntu (Debian-based) systems. These steps install OpenJDK, add the official Jenkins repository, install Jenkins, start the service, and show how to retrieve the initial admin password.

> Run these commands in a terminal with sudo (or as root).

## 1) Install Java (OpenJDK 21 or 17)
Jenkins requires Java. Newer Jenkins versions work with Java 21 or later. OpenJDK 21 is a safe default.

```bash
sudo apt update
sudo apt install -y openjdk-21-jdk

# Verify Java
java -version
```

If you prefer Java 17 (supported by recent Jenkins releases):

```bash
sudo apt install -y openjdk-17-jdk
java -version
```

---

## 2) Add the Jenkins APT repository and key

```bash
# Import the Jenkins GPG key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```

---

## 3) Install Jenkins

```bash
# Update the system with jenkins 
sudo apt-get update

# Install the jenkins
sudo apt-get install -y jenkins

# Start and enable the service
sudo systemctl enable --now jenkins

# Check service status
sudo systemctl status jenkins --no-pager
```

---

## 4) Open firewall ports (if using UFW)

By default Jenkins listens on port 8080. If you use UFW:

```bash
sudo ufw allow 8080/tcp
sudo ufw reload
```

---

## 5) Retrieve initial admin password (for first-time setup)

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Visit: http://your_server_ip_or_hostname:8080 and enter this password to complete the setup.

---

## 6) Docker (Jenkins container)

Simple steps to build a custom Jenkins image and run it.

1) Pull the jenkins image
```bash
docker pull jenkins/jenkins:lts-jdk21
```

2) Create a persistent volume for Jenkins data (recommended)
```bash
docker volume create jenkins-data
```

3) Run the jenkins container with the volume attached
```bash
docker run -itd --name jenkins -p 8080:8080 -v jenkins-data:/var/jenkins_home jenkins/jenkins:lts-jdk21
```

Recreate and reuse data later
```bash
# Stop and remove old container (data is preserved in the "jenkins-data" volume)
docker stop jenkins && docker rm jenkins -f

# Start a new container pointing to the same volume
docker run -itd --name jenkins -p 8080:8080 -v jenkins-data:/var/jenkins_home jenkins/jenkins:lts-jdk21
```

Notes:
- Access Jenkins at http://your-server-ip:8080 (or your host IP).
- View initial admin password: `docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`.

---
## 7) Post-install suggestions

- Install recommended plugins from the Jenkins setup wizard or select specific plugins for your CI/CD needs.
- Create an admin user via the setup flow or configure using CLI/Configuration as Code for automation.
- If running behind a reverse proxy (NGINX/Apache), configure proxy settings and set Jenkins' HTTP port accordingly.

---

If you'd like, I can also:
- Add a systemd unit override example to run Jenkins on a different port.
- Add NGINX reverse proxy configuration snippets.
- Provide an automated script that installs Java, Jenkins, and optionally configures UFW.

---
## ⚠️ Important Alert
- If you encounter any issue please go through [official documentation](https://www.jenkins.io/doc/book/)
- If you face any problem and help please contact the system admin/team lead

