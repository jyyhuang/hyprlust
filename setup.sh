#!/bin/bash

# Exit on errors
set -eou pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PKG_LIST="$SCRIPT_DIR/pkglist.txt"
AUR_LIST="$SCRIPT_DIR/aurlist.txt"

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

# Keep sudo alive while the script runs
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [[ ! -f "$PKG_LIST" || ! -f "$AUR_LIST" ]]; then
  echo "Error: Package lists (pkglist.txt or aurlist.txt) not found in $SCRIPT_DIR"
  exit 1
fi

# Install AUR helper (paru) if not installed
if ! command -v paru &>/dev/null; then
  if ask_confirmation "paru not found. Do you want to install paru?"; then
    echo "Installing paru dependencies..."
    sudo pacman -S --needed base-devel git

    TEMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TEMP_DIR"' EXIT
    git clone https://aur.archlinux.org/paru.git "$TEMP_DIR/paru"
    pushd "$TEMP_DIR/paru" > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf "$TEMP_DIR"
  fi
fi

# Install Pacman packages
# pacman -Qqen > pkglist.txt
if ask_confirmation "Do you want to install Pacman packages?"; then
  echo "Updating system and installing official packages..."
  sudo pacman -Syu --needed - < "$PKG_LIST"
fi

# Install AUR packages
# pacman -Qqem > aurlist.txt
if command -v paru &>/dev/null; then
  if ask_confirmation "Do you want to install AUR packages?"; then
    echo "Installing AUR packages..."
    paru -S --needed - < "$AUR_LIST"
  fi
else
  echo "Skipping AUR packages (paru not installed)."
fi

# Copy files
if ask_confirmation "Do you want to sync config files and wallpapers?"; then
  echo "Syncing files to $HOME..."

  mkdir -p ~/.config ~/.local/share ~/wallpapers
  
  [[ -d "$SCRIPT_DIR/.config" ]] && rsync -av "$SCRIPT_DIR/.config/" ~/.config/
  [[ -d "$SCRIPT_DIR/.local" ]]  && rsync -av "$SCRIPT_DIR/.local/" ~/.local/
  [[ -d "$SCRIPT_DIR/wallpapers" ]] && rsync -av "$SCRIPT_DIR/wallpapers/" ~/wallpapers/
  [[ -f "$SCRIPT_DIR/.zshrc" ]]  && cp "$SCRIPT_DIR/.zshrc" ~/.zshrc
  
  if [[ -f "$SCRIPT_DIR/reflector.conf" ]]; then
    sudo cp "$SCRIPT_DIR/reflector.conf" /etc/xdg/reflector/reflector.conf
  fi
  
  echo "File sync complete."
fi

# Enable and start services
SERVICES=("ufw.service" "reflector.service" "docker.socket" "fstrim.timer" "paccache.timer" "systemd-timesyncd")

if ask_confirmation "Do you want to enable/start services (${SERVICES[*]})?"; then

  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw enable

  for svc in "${SERVICES[@]}"; do
    echo "Setting up $svc..."
    sudo systemctl enable --now "$svc"
  done

fi

if [[ "$SHELL" != */zsh ]]; then
  if command -v zsh &>/dev/null; then
    if ask_confirmation "Would you like to change your default shell to ZSH?"; then
      echo "Changing shell to zsh..."
      chsh -s /usr/bin/zsh
      echo "Shell changed. You may need to log out and back in for this to take effect."
    fi
  else
    echo "ZSH is not installed. Skipping shell change."
  fi
fi

echo "--- Setup Finished Successfully ---"
