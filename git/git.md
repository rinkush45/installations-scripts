# Git installation commands
Below are short, copyable installation commands and brief descriptions for Debian-based Linux, macOS, and Windows. Run the platform section that applies to your machine.

---

## Debian / Ubuntu (and other Debian-based Linux)

Description: Installs Git from the distribution package repositories. This is the simplest option and provides a stable version maintained by your distro. For the latest Git version, consider adding a third-party PPA (optional).

Commands (run in a terminal):

```bash
# Update package lists and install git
sudo apt update && sudo apt install -y git

# (Optional) Verify installation
git --version
```

Optional: Install a newer Git from the official PPA (Ubuntu only):

```bash
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update && sudo apt install -y git
git --version
```

---

## macOS

Description: Two common methods — Homebrew (recommended) or the Xcode Command Line Tools. Homebrew gives more control and easy upgrades. Xcode CLI installs a Git shipped by Apple.

Commands — Homebrew (recommended):

```bash
# Install Homebrew if you don't have it (only if needed):
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install git via Homebrew
brew update
brew install git

# Verify
git --version
```

Commands — Xcode Command Line Tools (quick, no Homebrew):

```bash
xcode-select --install
# Then verify
git --version
```

---

## Windows (PowerShell)

Description: Three common Windows options — winget (built-in on modern Windows),Chocolatey and UI based. Both install Git for Windows which includes Git Bash and Git GUI.

Commands — winget (recommended if available):

```powershell
# Run in an elevated PowerShell (Run as Administrator)
winget install --id Git.Git -e --source winget

# Verify from PowerShell
git --version
```

Commands — Chocolatey (if you prefer choco):

```powershell
# Install Chocolatey (if not already installed; run in elevated PowerShell)
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Git
choco install git -y

# Verify
git --version
```

UI based Install
- Go to the [official docs](https://git-scm.com/)

---

## Minimal recommended post-install configuration (run once per user)

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global core.editor "code --wait"  # optional: Visual Studio Code
git config --global init.defaultBranch main
```

## Verify Git is working

```bash
git --version
git config --list --show-origin
```
---
## Scripted install using `git.scrpit`
Use the ready-made script for a one-command setup (Ubuntu/macOS):

```bash
# From the repository root
bash "Testing/Installaation cmd/git.scrpit"
```

- On Ubuntu/Debian it uses apt; on macOS it uses Homebrew (installs if missing).
- On Windows, the script prints `winget` and Chocolatey commands to run in PowerShell.
- Official docs: https://git-scm.com/

Notes:
- Replace the user.name and user.email values with your own.
- On Windows, running commands that install packages requires an elevated PowerShell (Administrator).
- If you want a script that detects the OS and runs the appropriate installer, I can provide that next.

## ⚠️ Important Alert
- If you encounter any issue please go through [official documentation](https://git-scm.com/)
- If you face any problem and help please contact the system admin/team lead
