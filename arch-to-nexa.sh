# Copyright (C) 2025 Nexa Linux

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

#!/bin/bash

# variables
ver="1.0.0"

# splash
echo
echo "███    ██ ███████ ██   ██  █████      ██      ██ ███    ██ ██    ██ ██   ██ "
echo "████   ██ ██       ██ ██  ██   ██     ██      ██ ████   ██ ██    ██  ██ ██  "
echo "██ ██  ██ █████     ███   ███████     ██      ██ ██ ██  ██ ██    ██   ███   "
echo "██  ██ ██ ██       ██ ██  ██   ██     ██      ██ ██  ██ ██ ██    ██  ██ ██  "
echo "██   ████ ███████ ██   ██ ██   ██     ███████ ██ ██   ████  ██████  ██   ██ "
echo
echo "Arch Linux to Nexa Linux converter - Made with love by the Nexa Linux team"
echo Version $ver
echo 
echo "[INFO] Running checks..."

# check if user is running in TTY
terminal_type=$(tty)

if [[ "$(tty)" == /dev/tty* ]]; then
    echo "Running in a TTY"
else
    echo "Not running in a TTY! To enter a TTY, press CTRL + SHIFT + F5 on your keyboard."
    exit 1
fi

# check if user is running Arch Linux
if [[ -f "/etc/arch-release" ]]; then
    echo "Arch Linux detected"
else
    echo "You are not running Arch Linux! Please try running me on an Arch Linux PC."
    exit 1
fi

# check if user is already running Nexa Linux
if [[ -f "/etc/this-is-nexa" ]]; then
  echo "Nexa Linux has been detected."
  exit 1
else
  echo "Nexa Linux wasn't detected."
fi

# confirmation
sleep 10

# check if user selected yes or no
while true; do
    echo "[WARNING] The creators of this script are not responsible for any damages caused to your PC."
    read -p "Do you want to continue? (Y/n): " choice
    
    if [[ "$choice" == "Y" ]]; then
        break
    elif [[ "$choice" == "n" || "$choice" == "N" ]]; then
        exit 0
    else
        echo "[ERROR] Invalid choice."
    fi
done

# removing Desktop Environments
# function to check if DE binaries exist
check_de() {
    command -v "$1" &> /dev/null
}

if check_de "gnome-shell"; then
    echo "GNOME detected..."
    sudo pacman -y -Rns gnome gnome-shell gdm
elif check_de "plasmashell"; then
    echo "KDE Plasma detected..."
    sudo pacman -y -Rns plasma-desktop sddm
elif check_de "xfce4-session"; then
    echo "XFCE detected..."
    sudo pacman -y -Rns xfce4 xfce4-goodies lightdm
elif check_de "mate-session"; then
    echo "MATE detected..."
    sudo pacman -y -Rns mate lightdm
elif check_de "cinnamon-session"; then
    echo "Cinnamon detected..."
    sudo pacman -y -Rns cinnamon lightdm
elif check_de "startlxqt"; then
    echo "LXQt detected..."
    sudo pacman -y -Rns lxqt lightdm
elif check_de "startlxde"; then
    echo "LXDE detected..."
    sudo pacman -y -Rns lxde lightdm
elif check_de "budgie-desktop"; then
    echo "Budgie detected..."
    sudo pacman -y -Rns budgie-desktop lightdm
elif check_de "deepin-session"; then
    echo "Deepin detected..."
    sudo pacman -y -Rns deepin lightdm
elif check_de "i3"; then
    echo "i3 detected..."
    sudo pacman -y -Rns i3-wm i3status i3lock
elif check_de "openbox"; then
    echo "Openbox detected..."
    sudo pacman -y -Rns openbox lightdm
elif check_de "fluxbox"; then
    echo "Fluxbox detected..."
    sudo pacman -y -Rns fluxbox lightdm
elif check_de "awesome"; then
    echo "Awesome detected..."
    sudo pacman -y -Rns awesome lightdm
elif check_de "sway"; then
    echo "Sway detected..."
    sudo pacman -y -Rns sway lightdm
elif check_de "bspwm"; then
    echo "Bspwm detected..."
    sudo pacman -y -Rns bspwm lightdm
elif check_de "xmonad"; then
    echo "Xmonad detected..."
    sudo pacman -y -Rns xmonad lightdm
elif check_de "herbstluftwm"; then
    echo "Herbstluftwm detected..."
    sudo pacman -y -Rns herbstluftwm lightdm
elif check_de "ratpoison"; then
    echo "Ratpoison detected..."
    sudo pacman -y -Rns ratpoison lightdm
elif check_de "icewm"; then
    echo "IceWM detected..."
    sudo pacman -y -Rns icewm lightdm
elif check_de "jwm"; then
    echo "JWM detected..."
    sudo pacman -y -Rns jwm lightdm
elif check_de "wayfire"; then
    echo "Wayfire detected..."
    sudo pacman -y -Rns wayfire lightdm
elif check_de "qtile"; then
    echo "Qtile detected..."
    sudo pacman -y -Rns qtile lightdm
elif check_de "cde"; then
    echo "CDE detected..."
    sudo pacman -y -Rns cdesktopenv lightdm
elif check_de "lumina"; then
    echo "Lumina detected..."
    sudo pacman -y -Rns lumina-desktop lightdm
elif check_de "hyprland"; then
    echo "Hyprland detected..."
    sudo pacman -y -Rns hyprland
else
    echo "[INFO] I haven't found any Desktop Environment known to me on this system."
    echo "[WARNING] If the script continues with a DE installed, this will cause broken behavior."
    echo "!!! Continuing in 20 seconds, if you do have a DE, please CTRL + C and remove it manually, then run the script again. !!!"
    sleep 20
    break  
fi

# installing dependencies
echo "[INFO] Updating Arch Linux repositories"
sudo pacman -Sy
echo "[INFO] Installing Git..."
sudo pacman -S --noconfirm --needed git
echo "[INFO] Installing KDE Plasma..."
sudo pacman -S --noconfirm --needed plasma
echo "[INFO] Installing Wayland..."
sudo pacman -S --noconfirm --needed wayland
sudo pacman -S --noconfirm --needed egl-wayland

# time to shine! setting up
echo "[INFO] Making directories..."
sudo mkdir /tmp/nexa-tmp/
echo "[INFO] Adding Nexa Linux repository..."
sudo sh -c 'echo "[nexa-pkg]" >> /etc/pacman.conf && echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf && echo "Server = https://packages.nexalinux.xyz/" >> /etc/pacman.conf'
echo "[INFO] Cloning artwork..."
sudo git clone https://github.com/NexaLinux/artwork /tmp/nexa-tmp/artwork/
sudo pacman -Syy
echo "[INFO] Marking as Nexa Linux installation..."
sudo sh -c "echo > /etc/this-is-nexa"
echo "[INFO] Cloning pixmaps..."
sudo git clone https://github.com/NexaLinux/pixmaps /tmp/nexa-tmp/pixmaps/
echo "[INFO] Cloning SDDM theme..."
sudo git clone https://github.com/NexaLinux/nexa-wood /tmp/nexa-tmp/nexa-wood/

# time to shine! installing
echo "[INSTALL] Adding wallpapers..."
sudo cp -r /tmp/nexa-tmp/artwork/ /usr/share/wallpapers/
echo "[INSTALL] Changing DM to SDDM..."
sudo rm /etc/systemd/system/display-manager.service
sudo systemctl enable sddm
echo "[INSTALL] Changing pixmaps..."
sudo rm /usr/share/pixmaps/archlinux-logo.png
sudo rm /usr/share/pixmaps/archlinux-logo.svg
sudo rm /usr/share/pixmaps/archlinux-logo-text-dark.svg
sudo rm /usr/share/pixmaps/archlinux-logo-text.svg
sudo cp /tmp/nexa-tmp/pixmaps/*.png /usr/share/pixmaps/
sudo cp /tmp/nexa-tmp/pixmaps/*.svg /usr/share/pixmaps/
echo "[INSTALL] Changing OS info"
sudo rm /etc/os-release
sudo cp /tmp/nexa-tmp/pixmaps/os-release /etc/
echo "[INSTALL] Installing SDDM theme..."
sudo cp -R /tmp/nexa-tmp/nexa-wood/ /usr/share/sddm/themes/
sudo rm /etc/sddm.conf
sudo sh -c 'echo "[General]" >> /etc/sddm.conf'
sudo sh -c 'echo "DisplayServer=wayland" >> /etc/sddm.conf'
sudo sh -c 'echo "GreeterEnvironment=" >> /etc/sddm.conf'
sudo sh -c 'echo "InputMethod=" >> /etc/sddm.conf'
sudo sh -c 'echo "Namespaces=" >> /etc/sddm.conf'
sudo sh -c 'echo "Numlock=none" >> /etc/sddm.conf'
sudo sh -c 'echo "[Theme]" >> /etc/sddm.conf'
sudo sh -c 'echo "CursorSize=24" >> /etc/sddm.conf'
sudo sh -c 'echo "DisableAvatarsThreshold=7" >> /etc/sddm.conf'
sudo sh -c 'echo "EnableAvatars=false" >> /etc/sddm.conf'
sudo sh -c 'echo "FacesDir=/usr/share/sddm/faces" >> /etc/sddm.conf'
sudo sh -c 'echo "Font=" >> /etc/sddm.conf'
sudo sh -c 'echo "ThemeDir=/usr/share/sddm/themes" >> /etc/sddm.conf'
sudo sh -c 'echo "Current=nexa-wood" >> /etc/sddm.conf'
sudo sh -c 'echo "[Users]" >> /etc/sddm.conf'
sudo sh -c 'echo "DefaultPath=/usr/local/sbin:/usr/local/bin:/usr/bin" >> /etc/sddm.conf'
sudo sh -c 'echo "HideShells=" >> /etc/sddm.conf'
sudo sh -c 'echo "HideUsers=" >> /etc/sddm.conf'
sudo sh -c 'echo "RememberLastSession=true" >> /etc/sddm.conf'
sudo sh -c 'echo "RememberLastUser=true" >> /etc/sddm.conf'
sudo sh -c 'echo "ReuseSession=true" >> /etc/sddm.conf'
sudo sh -c 'echo "[Wayland]" >> /etc/sddm.conf'
sudo sh -c 'echo "CompositorCommand=weston --shell=fullscreen-shell.so" >> /etc/sddm.conf'
sudo sh -c 'echo "EnableHiDPI=true" >> /etc/sddm.conf'
sudo sh -c 'echo "SessionCommand=/usr/share/sddm/scripts/wayland-session" >> /etc/sddm.conf'
sudo sh -c 'echo "SessionDir=/usr/local/share/wayland-sessions,/usr/share/wayland-sessions" >> /etc/sddm.conf'
sudo sh -c 'echo "SessionLogFile=.local/share/sddm/wayland-session.log" >> /etc/sddm.conf'
sudo sh -c 'echo "[X11]" >> /etc/sddm.conf'
sudo sh -c 'echo "DisplayCommand=/usr/share/sddm/scripts/Xsetup" >> /etc/sddm.conf'
sudo sh -c 'echo "DisplayStopCommand=/usr/share/sddm/scripts/Xstop" >> /etc/sddm.conf'
sudo sh -c 'echo "EnableHiDPI=true" >> /etc/sddm.conf'
sudo sh -c 'echo "ServerArguments=-nolisten tcp" >> /etc/sddm.conf'
sudo sh -c 'echo "ServerPath=/usr/bin/X" >> /etc/sddm.conf'
sudo sh -c 'echo "SessionCommand=/usr/share/sddm/scripts/Xsession" >> /etc/sddm.conf'
sudo sh -c 'echo "SessionDir=/usr/local/share/xsessions,/usr/share/xsessions" >> /etc/sddm.conf'
sudo sh -c 'echo "SessionLogFile=.local/share/sddm/xorg-session.log" >> /etc/sddm.conf'
sudo sh -c 'echo "XephyrPath=/usr/bin/Xephyr" >> /etc/sddm.conf'

# install yay (AUR helper)
echo "[INSTALL] Installing AUR helper (yay)..."
sudo pacman -S --noconfirm --needed base-devel
git clone https://aur.archlinux.org/yay-bin.git ~/yay/
cd ~/yay/
makepkg -si
rm -rf ~/yay/

# setting up packages
echo "[INSTALL] Setting up packages..."
sudo pacman -Sy
sudo pacman -Syy
sudo pacman -Syu
sudo pacman -S --noconfirm nexa-cmd
sudo pacman -R --noconfirm firefox
sudo pacman -S --noconfirm flatpak
sudo pacman -S --noconfirm --needed plasma-meta
sudo pacman -S --noconfirm --needed plasma-workspace
sudo pacman -S --noconfirm --needed dolphin
sudo pacman -S --noconfirm --needed ark
sudo pacman -S --noconfirm --needed konsole
yay -S brave-bin --noconfirm
yay -S vscodium-bin --noconfirm

# done
echo Done installing! Please reboot your PC.
echo
exit 0
