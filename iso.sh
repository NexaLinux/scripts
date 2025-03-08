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

echo "[ISO] Installing Calamares (eggs)"
sudo eggs calamares --install --theme nexa

echo "[ISO] Running configuration"
sudo eggs dad

echo "[ISO] Producing an egg!"
sudo eggs produce --theme nexa --release --noicon --clone
