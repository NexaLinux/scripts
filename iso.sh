#!/bin/bash

echo "[ISO] Installing dependencies"
sudo pacman -S git tar --needed --noconfirm

echo "[ISO] Making directories"
mkdir /tmp/prod

echo "[ISO] Installing Penguins' eggs"
git clone https://github.com/pieroproietti/get-eggs /tmp/prod/get-eggs/
cd /tmp/prod/get-eggs/
sudo ./get-eggs.sh

echo "[ISO] Adding Calamares theme"
rm -rf /usr/lib/penguins-eggs/addons/eggs/theme/calamares/branding/
git clone https://github.com/NexaLinux/calamares /usr/lib/penguins-eggs/addons/eggs/theme/calamares/branding

echo "[ISO] Installing Calamares (eggs)"
sudo eggs calamares --install

echo "[ISO] Running configuration"
sudo eggs dad

echo "[ISO] Producing an egg!"
sudo eggs produce --excludes homes --release --clone --noicon
