#!/bin/bash

echo "[ISO] Installing dependencies"
sudo pacman -S git tar --needed --noconfirm

echo "[ISO] Making directories"
mkdir /tmp/prod

echo "[ISO] Installing Penguins' eggs"
git clone https://github.com/pieroproietti/get-eggs /tmp/prod/get-eggs/
cd /tmp/prod/get-eggs/
sudo ./get-eggs.sh

echo "[ISO] Cloning Calamares theme"
git clone https://github.com/NexaLinux/calamares /tmp/prod/calamares/

echo "[ISO] Installing Calamares (eggs)"
sudo eggs calamares --install --theme=/tmp/prod/calamares/

echo "[ISO] Running configuration"
sudo eggs dad

echo "[ISO] Producing an egg!"
sudo eggs produce --excludes homes --release --theme=/tmp/prod/calamares/
