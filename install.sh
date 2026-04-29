#!/usr/bin/env bash
set -e

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
