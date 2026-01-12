#!/bin/bash

# Exit on errors
set -e

PKG_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"

ask_confirmation() {
  local prompt="$1"
  while true; do
    read -p "$prompt (y/n): " answer
    answer=${answer,,} # Convert to lowercase
    if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
      return 0
    elif [[ "$answer" == "no" || "$answer" == "n" ]]; then
      return 1
    else
      echo "Invalid input. Please enter yes or no."
    fi
  done
}

# Check if package lists exist
if [ ! -f "$PKG_LIST" ]; then
  echo "Package list ($PKG_LIST) not found"
  exit 1
fi

if [ ! -f "$AUR_LIST" ]; then
  echo "AUR package list ($AUR_LIST) not found"
  exit 1
fi

# Install Pacman packages
# pacman -Qqen > pkglist.txt
if ask_confirmation "Do you want to install Pacman packages?"; then
  echo "Updating system and installing official packages..."
  if ! sudo pacman -Syu --needed - <"$PKG_LIST"; then
    echo "Error installing official packages."
    exit 1
  fi
fi

# Install AUR helper (paru) if not installed
if ! command -v paru &>/dev/null; then
  if ask_confirmation "paru not found. Do you want to install paru?"; then
    sudo pacman -S --needed base-devel git
    rm -rf paru && git clone https://aur.archlinux.org/paru.git || {
      echo "Failed to clone paru."
      exit 1
    }
    cd paru || exit 1
    if ! makepkg -si; then
      echo "Failed to build and install paru."
      exit 1
    fi
    cd .. && rm -rf paru
  fi
fi

# Install AUR packages
# pacman -Qqem > aurlist.txt
if ask_confirmation "Do you want to install AUR packages?"; then
  echo "Installing AUR packages..."
  if ! paru -S --needed - <"$AUR_LIST"; then
    echo "Error installing AUR packages."
    exit 1
  fi
fi

echo "All packages installed successfully."

# Enable and start services
SERVICES=("NetworkManager.service" "ufw.service" "reflector.timer" "grub-btrfsd.service" "ly@tty2.service" "cronie.service")

echo "The following systemd units will be enabled and started:"
for svc in "${SERVICES[@]}"; do
  echo "  • $svc"
done
echo

if ask_confirmation "Do you want to enable and start system services?"; then
  for svc in "${SERVICES[@]}"; do
    echo "Enabling and starting $svc..."
    if ! sudo systemctl enable --now "$svc"; then
      echo "Failed to enable/start $svc"
    fi
  done
fi

echo "All packages installed successfully and services enabled (if selected)."
