#!/usr/bin/env bash
set -e

if [[ ! -d "dotfiles" ]]; then
    echo "Error: 'dotfiles' directory not found."
    echo "Please clone the repository and run this script from inside it:"
    echo "  git clone https://github.com/theblack-don/seabee-dots.git"
    echo "  cd seabee-dots"
    echo "  bash install.sh"
    exit 1
fi

echo "==> Updating package list..."
sudo apt update

echo "==> Installing packages..."
sudo apt install -y \
  niri \
  noctalia-shell \
  xwayland-satellite \
  hx \
  fastfetch \
  fish \
  qt5ct \
  qt6ct \
  qml6-module-qt-labs-folderlistmodel \
  qt6-wayland \
  kitty \
  nemo

echo "==> Creating directories..."
mkdir -p ~/.config
mkdir -p ~/Pictures/Wallpapers

echo "==> Copying dotfiles to ~/.config/..."
cp -r dotfiles/* ~/.config/

echo "==> Copying wallpapers to ~/Pictures/Wallpapers/..."
cp wallpapers/* ~/Pictures/Wallpapers/

echo "==> Patching Noctalia wallpaper directory..."
sed -i "s|/home/don/.config/dcli/wallpapers|/home/$USER/Pictures/Wallpapers|g" ~/.config/noctalia/settings.json

echo "==> Setting default wallpaper..."
qs -c noctalia-shell ipc call wallpaper set "/home/$USER/Pictures/Wallpapers/37.png" "" || true

echo "==> Done! Dotfiles installed successfully."
