#!/bin/bash

# Exit on errors
set -e

# Check if package lists exist
if [ ! -f pkglist.txt ]; then
  echo "Package list (pkglist.txt) not found"
  exit 1
fi

if [ ! -f aurlist.txt ]; then
  echo "AUR package list (aurlist.txt) not found"
  exit 1
fi

# Update the system and install official Pacman packages
echo "Installing official Pacman packages..."
if ! sudo pacman -Syu --needed - < pkglist.txt; then
  echo "Error installing official packages."
  exit 1
fi

# Install AUR helper (paru) if not already installed
if ! command -v paru &> /dev/null; then
  echo "paru not found. Installing paru..."
  sudo pacman -S --needed base-devel git
if [ -d paru ]; then
    echo "Removing existing paru directory."
    rm -rf paru
  fi
  git clone https://aur.archlinux.org/paru.git || { echo "Failed to clone paru."; exit 1; }
  cd paru || { echo "Failed to enter paru directory."; exit 1; }
  if ! makepkg -si; then
    echo "Failed to build and install paru."
    cd ..
    rm -rf paru
    exit 1
  fi
  cd .. && rm -rf paru
fi

# Install AUR packages
echo "Installing AUR packages..."
if ! paru -S --needed - < aurlist.txt; then
  echo "Error installing AUR packages."
  exit 1
fi

echo "All packages installed successfully."
