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

# splash
echo
echo "███    ██ ███████ ██   ██  █████      ██      ██ ███    ██ ██    ██ ██   ██ "
echo "████   ██ ██       ██ ██  ██   ██     ██      ██ ████   ██ ██    ██  ██ ██  "
echo "██ ██  ██ █████     ███   ███████     ██      ██ ██ ██  ██ ██    ██   ███   "
echo "██  ██ ██ ██       ██ ██  ██   ██     ██      ██ ██  ██ ██ ██    ██  ██ ██  "
echo "██   ████ ███████ ██   ██ ██   ██     ███████ ██ ██   ████  ██████  ██   ██ "
echo
echo Arch Linux to Nexa Linux converter - Made with ❤️ by the Nexa Linux team
echo "ℹ️ [INFO] Running checks..."

# check if user running in tty
terminal_type=$(tty)

if [[ "$(tty)" == /dev/tty* ]]; then
    echo "✅ Running in a TTY"
else
    echo "❌ Not running in a TTY! To enter a TTY, press CTRL + SHIFT + F5 on your keyboard."
    exit 1
fi

# check if user is running arch linux
if [[ -f "/etc/arch-release" ]]; then
    echo "✅ Arch Linux detected"
else
    echo "❌ You are not running Arch Linux! Please try running me on an Arch Linux PC."
    exit 1
fi

# check if user is already running nexa linux
if [[ -f "/etc/this-is-nexa" ]]; then
  echo "❌ Nexa Linux has been detected."
  exit 1
else
  echo "✅ Nexa Linux wasn't detected."
fi

# confirmation
sleep 10

# check if user selected yes or no
while true; do
    echo "⚠️ [WARNING] The makers of this script are not responsible for any damages caused to your PC."
    read -p "Do you want to continue? (y/n): " choice
    
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        break
    elif [[ "$choice" == "n" || "$choice" == "N" ]]; then
        exit 0
    else
        echo "⛔ [ERROR] Invalid choice."
    fi
done

# removing DE's
# function to check if DE binaries exist
check_binary() {
    command -v "$1" &> /dev/null
}

if check_binary "gnome-shell"; then
    echo "GNOME detected..."
    sudo pacman -y -Rns gnome gnome-shell gdm
elif check_binary "plasmashell"; then
    echo "KDE Plasma detected..."
    sudo pacman -y -Rns plasma-desktop sddm
elif check_binary "xfce4-session"; then
    echo "XFCE detected..."
    sudo pacman -y -Rns xfce4 xfce4-goodies lightdm
elif check_binary "mate-session"; then
    echo "MATE detected..."
    sudo pacman -y -Rns mate lightdm
elif check_binary "cinnamon-session"; then
    echo "Cinnamon detected..."
    sudo pacman -y -Rns cinnamon lightdm
elif check_binary "startlxqt"; then
    echo "LXQt detected..."
    sudo pacman -y -Rns lxqt lightdm
elif check_binary "startlxde"; then
    echo "LXDE detected..."
    sudo pacman -y -Rns lxde lightdm
elif check_binary "budgie-desktop"; then
    echo "Budgie detected..."
    sudo pacman -y -Rns budgie-desktop lightdm
elif check_binary "deepin-session"; then
    echo "Deepin detected..."
    sudo pacman -y -Rns deepin lightdm
elif check_binary "i3"; then
    echo "i3 detected..."
    sudo pacman -y -Rns i3-wm i3status i3lock
elif check_binary "openbox"; then
    echo "Openbox detected..."
    sudo pacman -y -Rns openbox lightdm
elif check_binary "fluxbox"; then
    echo "Fluxbox detected..."
    sudo pacman -y -Rns fluxbox lightdm
elif check_binary "awesome"; then
    echo "Awesome detected..."
    sudo pacman -y -Rns awesome lightdm
elif check_binary "sway"; then
    echo "Sway detected..."
    sudo pacman -y -Rns sway lightdm
elif check_binary "bspwm"; then
    echo "Bspwm detected..."
    sudo pacman -y -Rns bspwm lightdm
elif check_binary "xmonad"; then
    echo "Xmonad detected..."
    sudo pacman -y -Rns xmonad lightdm
elif check_binary "herbstluftwm"; then
    echo "Herbstluftwm detected..."
    sudo pacman -y -Rns herbstluftwm lightdm
elif check_binary "ratpoison"; then
    echo "Ratpoison detected..."
    sudo pacman -y -Rns ratpoison lightdm
elif check_binary "icewm"; then
    echo "IceWM detected..."
    sudo pacman -y -Rns icewm lightdm
elif check_binary "jwm"; then
    echo "JWM detected..."
    sudo pacman -y -Rns jwm lightdm
elif check_binary "wayfire"; then
    echo "Wayfire detected..."
    sudo pacman -y -Rns wayfire lightdm
elif check_binary "qtile"; then
    echo "Qtile detected..."
    sudo pacman -y -Rns qtile lightdm
elif check_binary "cde"; then
    echo "CDE detected..."
    sudo pacman -y -Rns cdesktopenv lightdm
elif check_binary "lumina"; then
    echo "Lumina detected..."
    sudo pacman -y -Rns lumina-desktop lightdm
elif check_binary "hyprland"; then
    echo "Hyprland detected..."
    sudo pacman -y -Rns hyprland
else
    echo "ℹ️ [INFO] I haven't found any DE known to me on this system."
    echo "⚠️ [WARNING] If the script continues with a DE installed, this will cause broken behavior."
    echo "!!! Continuing in 20 seconds, if you do have a DE, please CTRL + C and remove it manually, then run the script again. !!!"
    sleep 20
    break  
fi

# installing dependencies
echo "ℹ️ [INFO] Installing Git..."
sudo pacman -S --confirm --needed git
echo "ℹ️ [INFO] Installing KDE Plasma..."
sudo pacman -S --confirm --needed plasma
echo "ℹ️ [INFO] Installing Wayland..."
sudo pacman -S --confirm --needed wayland

# time to shine! setting up
echo "ℹ️ [INFO] Making directories..."
sudo mkdir /tmp/nexa-tmp/
sudo mkdir /usr/share/nexa-sddm-wp/
echo "ℹ️ [INFO] Adding Nexa Linux repository..."
sudo sh -c 'echo "[nexa-pkg]" >> /etc/pacman.conf && echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf && echo "Server = https://packages.nexalinux.xyz/" >> /etc/pacman.conf'
echo "ℹ️ [INFO] Cloning other artwork..."
git clone https://github.com/NexaLinux/other-artwork /tmp/nexa-tmp/other-artwork/
echo "ℹ️ [INFO] Installing Nexa commands..."
sudo pacman -Sy
sudo pacman -S --confirm --needed nexa-cmd
echo "ℹ️ [INFO] Cloning GitHub profile..."
git clone https://github.com/NexaLinux/.github/ /tmp/nexa-tmp/github-profile/
echo "ℹ️ [INFO] Marking as Nexa Linux installation..."
sudo echo > /etc/this-is-nexa
echo "ℹ️ [INFO] Cloning pixmaps..."
git clone https://github.com/NexaLinux/pixmaps /tmp/nexa-tmp/pixmaps/

# time to shine! installing
echo "🔥 [INSTALL] Adding wallpapers..."
sudo cp -r /tmp/nexa-tmp/other-artwork/ /usr/share/wallpapers/
sudo cp -r /tmp/nexa-tmp/github-profile/wallpapers/ /usr/share/wallpapers/nexalinux/
echo "🔥 [INSTALL] Changing default wallpaper to \"/usr/share/wallpapers/nexalinux/wallpapers/dotted-logo.png\"..."
sudo mkdir -p /etc/skel/.config
sudo sh -c 'echo "[Containments][1][Wallpaper][org.kde.image][General]" >> /etc/skel/.config/plasma-org.kde.plasma.desktop-appletsrc'
sudo sh -c 'echo "Image=file:///usr/share/wallpapers/nexalinux/wallpapers/dotted-logo.png" >> /etc/skel/.config/plasma-org.kde.plasma.desktop-appletsrc'
sudo sh -c 'echo "SlidePaths=/usr/share/wallpapers/" >> /etc/skel/.config/plasma-org.kde.plasma.desktop-appletsrc'
echo "🔥 [INSTALL] Adding login screen wallpaper..."
sudo cp /usr/share/wallpapers/nexalinux/wallpapers/dotted-logo.png /usr/share/nexa-sddm-wp/lock.png
echo "🔥 [INSTALL] Changing DM to SDDM..."
sudo rm /etc/systemd/system/display-manager.service
sudo systemctl enable sddm
echo "🔥 [INSTALL] Changing pixmaps..."
sudo rm /usr/share/pixmaps/archlinux-logo.png
sudo rm /usr/share/pixmaps/archlinux-logo.svg
sudo rm /usr/share/pixmaps/archlinux-logo-text-dark.svg
sudo rm /usr/share/pixmaps/archlinux-logo-text.svg
sudo cp /tmp/nexa-tmp/pixmaps/*.png /usr/share/pixmaps/
sudo cp /tmp/nexa-tmp/pixmaps/*.svg /usr/share/pixmaps/
echo "🔥 [INSTALL] Changing /etc/os-release..."
sudo rm /etc/os-release
sudo cp /tmp/nexa-tmp/pixmaps/os-release /etc/
echo "🔥 [INSTALL] Installing SDDM theme..."
sudo rm /etc/sddm.conf
sudo echo "[General]" >> /etc/sddm.conf
sudo echo "DisplayServer=wayland" >> /etc/sddm.conf
sudo echo "GreeterEnvironment=" >> /etc/sddm.conf
sudo echo "InputMethod=" >> /etc/sddm.conf
sudo echo "Namespaces=" >> /etc/sddm.conf
sudo echo "Numlock=none" >> /etc/sddm.conf
sudo echo "[Theme]" >> /etc/sddm.conf
sudo echo "CursorSize=24" >> /etc/sddm.conf
sudo echo "DisableAvatarsThreshold=7" >> /etc/sddm.conf
sudo echo "EnableAvatars=false" >> /etc/sddm.conf
sudo echo "FacesDir=/usr/share/sddm/faces" >> /etc/sddm.conf
sudo echo "Font=" >> /etc/sddm.conf
sudo echo "ThemeDir=/usr/share/sddm/themes" >> /etc/sddm.conf
sudo echo "Current=nexasddm" >> /etc/sddm.conf
sudo echo "[Users]" >> /etc/sddm.conf
sudo echo "DefaultPath=/usr/local/sbin:/usr/local/bin:/usr/bin" >> /etc/sddm.conf
sudo echo "HideShells=" >> /etc/sddm.conf
sudo echo "HideUsers=" >> /etc/sddm.conf
sudo echo "RememberLastSession=true" >> /etc/sddm.conf
sudo echo "RememberLastUser=true" >> /etc/sddm.conf
sudo echo "ReuseSession=true" >> /etc/sddm.conf
sudo echo "[Wayland]" >> /etc/sddm.conf
sudo echo "CompositorCommand=weston --shell=fullscreen-shell.so" >> /etc/sddm.conf
sudo echo "EnableHiDPI=true" >> /etc/sddm.conf
sudo echo "SessionCommand=/usr/share/sddm/scripts/wayland-session" >> /etc/sddm.conf
sudo echo "SessionDir=/usr/local/share/wayland-sessions,/usr/share/wayland-sessions" >> /etc/sddm.conf
sudo echo "SessionLogFile=.local/share/sddm/wayland-session.log" >> /etc/sddm.conf
sudo echo "[X11]" >> /etc/sddm.conf
sudo echo "DisplayCommand=/usr/share/sddm/scripts/Xsetup" >> /etc/sddm.conf
sudo echo "DisplayStopCommand=/usr/share/sddm/scripts/Xstop" >> /etc/sddm.conf
sudo echo "EnableHiDPI=true" >> /etc/sddm.conf
sudo echo "ServerArguments=-nolisten tcp" >> /etc/sddm.conf
sudo echo "ServerPath=/usr/bin/X" >> /etc/sddm.conf
sudo echo "SessionCommand=/usr/share/sddm/scripts/Xsession" >> /etc/sddm.conf
sudo echo "SessionDir=/usr/local/share/xsessions,/usr/share/xsessions" >> /etc/sddm.conf
sudo echo "SessionLogFile=.local/share/sddm/xorg-session.log" >> /etc/sddm.conf
sudo echo "XephyrPath=/usr/bin/Xephyr" >> /etc/sddm.conf

# done
echo Done installing! Please reboot your PC.
echo
exit 0
