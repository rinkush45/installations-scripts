#!/usr/bin/env bash
set -euo pipefail

# Cross-platform Git install helper
# - Ubuntu/Debian: uses apt
# - macOS: uses Homebrew (installs if missing)
# - Windows: prints instructions for winget/Chocolatey

# Detect actual runtime OS
actual_uname=$(uname -s || true)
case "$actual_uname" in
  Linux)
    ACTUAL_OS="linux"
    ;;
  Darwin)
    ACTUAL_OS="macos"
    ;;
  MINGW*|MSYS*|CYGWIN*)
    ACTUAL_OS="windows"
    ;;
  *)
    ACTUAL_OS="unknown"
    ;;
esac

# Accept OS choice via first argument or prompt the user
normalize() { echo "$1" | tr '[:upper:]' '[:lower:]'; }
OS_CHOICE_INPUT="${1:-}"
if [[ -z "${OS_CHOICE_INPUT}" ]]; then
  echo "Select your OS to install Git commands for:"
  echo "  1) Ubuntu/Debian"
  echo "  2) macOS"
  echo "  3) Windows (show PowerShell commands)"
  read -r -p "Enter 1/2/3 or name (ubuntu/debian/macos/windows): " OS_CHOICE_INPUT
fi

OS_CHOICE="$(normalize "${OS_CHOICE_INPUT}")"

# Map choice to group and validate against actual OS
CHOICE_GROUP="unknown"
case "${OS_CHOICE}" in
  1|ubuntu|debian|linux|apt)
    CHOICE_GROUP="linux"
    ;;
  2|mac|macos|darwin)
    CHOICE_GROUP="macos"
    ;;
  3|win|windows|powershell)
    CHOICE_GROUP="windows"
    ;;
  *)
    echo "Unrecognized choice: '${OS_CHOICE_INPUT}'."
    echo "Valid options: ubuntu/debian, macos, windows (or 1/2/3)."
    exit 1
    ;;
esac

# Compatibility check
if [[ "${CHOICE_GROUP}" != "${ACTUAL_OS}" ]]; then
  # Special case: Linux without apt is not supported for ubuntu/debian flow
  if [[ "${CHOICE_GROUP}" == "linux" && "${ACTUAL_OS}" == "linux" && ! $(command -v apt || true) ]]; then
    echo "Wrong OS selection: selected Ubuntu/Debian (apt) but this Linux system doesn't have apt."
    echo "Use your distro's package manager instead (dnf/yum/pacman/zypper)."
    exit 2
  else
    echo "Wrong OS selection: you are running on '${ACTUAL_OS}', but selected '${CHOICE_GROUP}'."
    echo "Please rerun with the correct OS choice."
    exit 2
  fi
fi

print_done() {
  echo
  echo "Git installation steps completed."
  echo "Verify: git --version"
}

install_debian_ubuntu() {
  echo "[Ubuntu/Debian] Installing Git via apt..."
  sudo apt update
  sudo apt install -y git
  print_done
}

install_macos() {
  echo "[macOS] Installing Git via Homebrew..."
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed. You may need to follow brew's post-install messages."
  fi
  brew update
  brew install git || brew upgrade git || true
  print_done
}

print_windows_help() {
  cat <<'EOF'
[Windows] Run one of these in an elevated PowerShell (Run as Administrator):

# winget (recommended if available)
winget install --id Git.Git -e --source winget

# Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install git -y

Then verify:
 git --version
EOF
}

case "${OS_CHOICE}" in
  1|ubuntu|debian|linux|apt)
    install_debian_ubuntu
    ;;
  2|mac|macos|darwin)
    install_macos
    ;;
  3|win|windows|powershell)
    print_windows_help
    ;;
  *)
    echo "Unrecognized choice: '${OS_CHOICE_INPUT}'."
    echo "Valid options: ubuntu/debian, macos, windows (or 1/2/3)."
    exit 1
    ;;
esac 