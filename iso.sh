#!/bin/bash

echo "[ISO] Removing root password"
sudo passwd -l root

echo "[ISO] Installing dependencies"
sudo pacman -S git tar --needed --noconfirm

echo "[ISO] Making directories"
mkdir /tmp/prod
mkdir /home/root

echo "[ISO] Installing Penguins' eggs"
git clone https://github.com/pieroproietti/get-eggs /tmp/prod/get-eggs/
cd /tmp/prod/get-eggs/
sudo ./get-eggs.sh

echo "[ISO] Adding wardrobes"
git clone https://github.com/pieroproietti/penguins-wardrobe /home/root/.wardrobe/
mkdir /home/root/.wardrobe/vendors/nexa/theme/artwork
mkdir /home/root/.wardrobe/vendors/nexa/theme/applications
curl https://raw.githubusercontent.com/pieroproietti/penguins-wardrobe/refs/heads/main/vendors/spiral/theme/artwork/install-system.png --output /home/root/.wardrobe/vendors/nexa/theme/artwork/install-system.png
curl https://raw.githubusercontent.com/pieroproietti/penguins-wardrobe/refs/heads/main/vendors/spiral/theme/applications/install-system.desktop --output /home/root/.wardrobe/vendors/nexa/theme/applications/install-system.desktop

echo "[ISO] Installing Calamares (eggs)"
sudo eggs calamares --install --theme nexa

echo "[ISO] Running configuration"
sudo eggs dad

echo "[ISO] Producing an egg!"
sudo eggs produce --theme nexa --release --noicon
