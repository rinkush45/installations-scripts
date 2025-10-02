# Overview
To get started with Docker Engine on Ubuntu, make sure you [meet the prerequisites](https://docs.docker.com/engine/install/ubuntu/#prerequisites), and then follow the installation steps.

 ## Uninstall old Versions
 Before you can install Docker Engine, you need to uninstall any conflicting packages.

Your Linux distribution may provide unofficial Docker packages, which may conflict with the official packages provided by Docker. You must uninstall these packages before you install the official version of Docker Engine.

The unofficial package to unistall are:
- `docker.io`
- `docker-compose`
- `docker-compose-v2`
- `docker-doc`
- `podman-docker`

Moreover, Docker Engine depends on `containerd` and `runc`. Docker Engine bundles these dependencies as one bundle: `containerd.io`. If you have installed the `containerd` or `runc` previously, uninstall them to avoid conflicts with the versions bundled with Docker Engine.

Run the following command to uninstall all conflicting packages:
```
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

`apt-get` might report that you have none of these package installed

## Install using the `apt` repo
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker `apt` repository. Afterward, you can install and update Docker from the repository.
1. Set up docker's `apt` repository

	```
	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certiificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	
	# Add the repository to Apt sources
	echo \
  		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  		$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update

	```

2. Install the latest docker packages
	```
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	```

3. Start the docker engine
	```
	sudo systemctl enable --now docker
	```
4. Verify that the installation is successful by running the `hello-world` image:
	```
	sudo docker run hello-world
	```
	This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.
	
You have now successfully installed and started Docker Engine.

---
## Scripted install using `docker.sh`
Use the ready-made script for a one-command setup (Ubuntu):

```bash
# From the repository root
sudo bash "Testing/Installaation cmd/docker.sh"
```

- The script removes conflicts, adds Docker's apt repo, installs Docker Engine, enables the service, and runs hello-world.
- See the script for the sample hello-world output.
- [Official docs:](https://docs.docker.com/engine/install/)

## ⚠️ Important Alert
- If you encounter any issue please go through [official documentation](https://docs.docker.com/engine/install/)
- If you face any problem and help please contact the system admin/team lead


