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

import subprocess
import platform
import sys
import time
import os

if os.geteuid() != 0:
    print("[ERROR] This script must be run as root!")
    sys.exit(1)

if platform.system() != "Linux":
    print(f'Oh wow, {platform.system()}? Unfortunately, Nexa Linux contains "Linux" in it\'s name, not {platform.system()}...')
    sys.exit(1)

print()
print("███    ██ ███████ ██   ██  █████      ██      ██ ███    ██ ██    ██ ██   ██ ")
print("████   ██ ██       ██ ██  ██   ██     ██      ██ ████   ██ ██    ██  ██ ██  ")
print("██ ██  ██ █████     ███   ███████     ██      ██ ██ ██  ██ ██    ██   ███   ")
print("██  ██ ██ ██       ██ ██  ██   ██     ██      ██ ██  ██ ██ ██    ██  ██ ██  ")
print("██   ████ ███████ ██   ██ ██   ██     ███████ ██ ██   ████  ██████  ██   ██ ")
print()
print("NLCS (Nexa Linux Conversion Script) - Made by the Nexa Linux team.")
print("Development purposes only - Use at your own risk!")
print()
print("[INFO] Running checks...")

currenttty = subprocess.run("tty", text=True, shell=True, capture_output=True)
if "/dev/tty" in currenttty.stdout:
    print("[CHECK] Running in a TTY.")
else:
    print("[ERROR] Not running in a TTY! Press Ctrl + Alt + F5.")
    sys.exit(1)

osrelease = subprocess.run("cat /etc/os-release", text=True, shell=True, capture_output=True)
if "Ubuntu" in osrelease.stdout:
    print("[CHECK] Running Ubuntu.")
else:
    print("[ERROR] Different distro detected!")
    sys.exit(1)

if os.path.exists("/etc/this-is-nexa"):
    print("[ERROR] Running Nexa Linux!")
else:
    print("[CHECK] Not running Nexa Linux")

time.sleep(5)

print()
print("[WARNING] The creators of this script are not responsible for any damages caused to your PC.")

while True:
    choice = input("Do you want to continue? (Y/N): ")
    if choice.lower() == "y":
        break
    elif choice.lower() == "n":
        sys.exit(1)
    else:
        print("Invalid choice!")

def check_de(de_name):
    result = os.system(f"command -v {de_name} >nul 2>&1")
    return result == 0

# btw, this will also work if ubuntu-desktop is installed instead and remove ubuntu-desktop too
if check_de("gnome-shell"):
    print("GNOME detected...")
    os.system("apt -y purge gnome-shell gdm3")
elif check_de("plasmashell"):
    print("KDE Plasma detected...")
    os.system("apt -y purge plasma-desktop sddm")
elif check_de("xfce4-session"):
    print("XFCE detected...")
    os.system("apt -y purge xfce4 xfce4-goodies lightdm")
elif check_de("mate-session"):
    print("MATE detected...")
    os.system("apt -y purge mate-desktop-environment lightdm")
elif check_de("cinnamon-session"):
    print("Cinnamon detected...")
    os.system("apt -y purge cinnamon lightdm")
elif check_de("startlxqt"):
    print("LXQt detected...")
    os.system("apt -y purge lxqt lightdm")
elif check_de("startlxde"):
    print("LXDE detected...")
    os.system("apt -y purge lxde lightdm")
elif check_de("budgie-desktop"):
    print("Budgie detected...")
    os.system("apt -y purge budgie-desktop lightdm")
elif check_de("deepin-session"):
    print("Deepin detected...")
    print("[ERROR] Deepin is not in Ubuntu's APT sources! The package name can be anything, please remove it manually.")
elif check_de("i3"):
    print("i3 detected...")
    os.system("apt -y purge i3-wm i3status i3lock")
elif check_de("openbox"):
    print("Openbox detected...")
    os.system("apt -y purge openbox lightdm")
elif check_de("fluxbox"):
    print("Fluxbox detected...")
    os.system("apt -y purge fluxbox lightdm")
elif check_de("awesome"):
    print("Awesome detected...")
    os.system("apt -y purge awesome lightdm")
elif check_de("sway"):
    print("Sway detected...")
    os.system("apt -y purge sway lightdm")
elif check_de("bspwm"):
    print("Bspwm detected...")
    os.system("apt -y purge bspwm lightdm")
elif check_de("xmonad"):
    print("Xmonad detected...")
    os.system("apt -y purge xmonad lightdm")
elif check_de("herbstluftwm"):
    print("Herbstluftwm detected...")
    os.system("apt -y purge herbstluftwm lightdm")
elif check_de("ratpoison"):
    print("Ratpoison detected...")
    os.system("apt -y purge ratpoison lightdm")
elif check_de("icewm"):
    print("IceWM detected...")
    os.system("apt -y purge icewm lightdm")
elif check_de("jwm"):
    print("JWM detected...")
    os.system("apt -y purge jwm lightdm")
elif check_de("wayfire"):
    print("Wayfire detected...")
    os.system("apt -y purge wayfire lightdm")
elif check_de("qtile"):
    print("Qtile detected...")
    print("[ERROR] Qtile is not in Ubuntu's APT sources! The package name can be anything, please remove it manually.")
elif check_de("cde"):
    print("CDE detected...")
    os.system("apt -y purge cde")
elif check_de("lumina"):
    print("Lumina detected...")
    print("[ERROR] Lumina is not in Ubuntu's APT sources! The package name can be anything, please remove it manually.")
elif check_de("hyprland"):
    print("Hyprland detected...")
    print("[ERROR] Hyprland is not in Ubuntu's APT sources! The package name can be anything, please remove it manually.")
else:
    os.system("clear")
    print("[INFO] I haven't found any Desktop Environment known to me on this system.")
    print("[WARNING] If the script continues with a DE installed, this will cause broken behavior.")
    print("!!! Continuing in 20 seconds, if you do have a DE, please CTRL + C and remove it manually, then run the script again. !!!")
    time.sleep(20)

print("[INFO] Updating Ubuntu sources...")
os.system("apt update")

print("[INFO] Installing Git...")
os.system("apt install -y git")

print("[INFO] Installing KDE Plasma...")
os.system("apt install -y kde-plasma-desktop")

print("[INFO] Installing Wayland...")
os.system("apt install -y plasma-workspace-wayland")

print("[INFO] Making directories...")
os.system("mkdir /tmp/nexa-tmp/")
os.system("mkdir /etc/skel/.config/")
os.system("mkdir /etc/skel/.config/autostart/")

# print("[INFO] Adding Nexa Linux repository")
# todo: make pkg repository

print("[INFO] Cloning artwork...")
os.system("git clone https://github.com/NexaLinux/artwork /tmp/nexa-tmp/artwork/")

print("Marking this as a Nexa Linux installation...")
with open("/etc/this-is-nexa", "wb") as file:
    pass

print("[INFO] Cloning pixmaps...")
os.system("git clone https://github.com/NexaLinux/pixmaps /tmp/nexa-tmp/pixmaps/")

print("[INFO] Cloning SDDM theme...")
os.system("git clone https://github.com/NexaLinux/nexa-wood /tmp/nexa-tmp/nexa-wood/")

print("[INFO] Cloning auto wallpaper change script...")
os.system("git clone https://github.com/NexaLinux/plasma-default-wall /tmp/nexa-tmp/default-wallpaper/")

print("[INSTALL] Adding wallpapers...")
os.system("sudo cp -r /tmp/nexa-tmp/artwork/* /usr/share/wallpapers/")

print("[INSTALL] Changing default wallpaper...")
os.system("sudo cp -r /tmp/nexa-tmp/default-wallpaper/* /etc/skel/.config/")
os.system("sudo cp -r /tmp/nexa-tmp/default-wallpaper/* ~/.config/")
os.system("sudo rm /etc/skel/.config/README.md")
os.system("sudo rm /etc/skel/.config/LICENSE")
os.system("sudo rm ~/.config/README.md")
os.system("sudo rm ~/.config/LICENSE")

print("[INSTALL] Changing Display Manager to SDDM...")
os.system("sudo rm /etc/systemd/system/display-manager.service")
os.system("sudo systemctl enable sddm")

print("[INSTALL] Changing pixmaps...")
os.system("sudo rm /usr/share/pixmaps/archlinux-logo.png")
os.system("sudo rm /usr/share/pixmaps/archlinux-logo.svg")
os.system("sudo rm /usr/share/pixmaps/archlinux-logo-text-dark.svg")
os.system("sudo rm /usr/share/pixmaps/archlinux-logo-text.svg")
os.system("sudo cp /tmp/nexa-tmp/pixmaps/*.png /usr/share/pixmaps/")
os.system("sudo cp /tmp/nexa-tmp/pixmaps/*.svg /usr/share/pixmaps/")

print("[INSTALL] Changing OS info...")
os.system("sudo rm /etc/os-release")
os.system("sudo rm /usr/lib/os-release")
os.system("sudo cp /tmp/nexa-tmp/pixmaps/os-release /etc/")
os.system("sudo cp /tmp/nexa-tmp/pixmaps/os-release /usr/lib/")

print("[INSTALL] Installing SDDM theme...")
os.system("sudo cp -R /tmp/nexa-tmp/nexa-wood/ /usr/share/sddm/themes/")
os.system("sudo rm /etc/sddm.conf")

sddm = """[General]
DisplayServer=wayland
GreeterEnvironment=
InputMethod=
Namespaces=
Numlock=none

[Theme]
CursorSize=24
DisableAvatarsThreshold=7
EnableAvatars=false
FacesDir=/usr/share/sddm/faces
Font=
ThemeDir=/usr/share/sddm/themes
Current=nexa-wood

[Users]
DefaultPath=/usr/local/sbin:/usr/local/bin:/usr/bin
HideShells=
HideUsers=
RememberLastSession=true
RememberLastUser=true
ReuseSession=true

[Wayland]
CompositorCommand=weston --shell=fullscreen-shell.so
EnableHiDPI=true
SessionCommand=/usr/share/sddm/scripts/wayland-session
SessionDir=/usr/local/share/wayland-sessions,/usr/share/wayland-sessions
SessionLogFile=.local/share/sddm/wayland-session.log

[X11]
DisplayCommand=/usr/share/sddm/scripts/Xsetup
DisplayStopCommand=/usr/share/sddm/scripts/Xstop
EnableHiDPI=true
ServerArguments=-nolisten tcp
ServerPath=/usr/bin/X
SessionCommand=/usr/share/sddm/scripts/Xsession
SessionDir=/usr/local/share/xsessions,/usr/share/xsessions
SessionLogFile=.local/share/sddm/xorg-session.log
XephyrPath=/usr/bin/Xephyr
EnableXServer=true
FallbackSession=plasma"""

with open("/etc/sddm.conf", "w") as file:
    file.write(sddm) # would have not used a variable but it wants a bytes-like object.

print("[INSTALL] Setting up packages...")
# os.system("apt install -y nexa-cmd")
os.system("apt install -y flatpak")
os.system("apt install plasma-discover-backend-flatpak")
os.system("flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo")
os.system("apt install -y kde-config-flatpak")
os.system("apt install -y plasma-workspace")
os.system("apt install -y dolphin")
os.system("apt install -y ark")
os.system("apt install -y konsole")
os.system("apt install -y kde-spectacle")
os.system("dpkg -s curl >/dev/null 2>&1 || apt install -y curl")
os.system("curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg")
os.system('echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list')
os.system("apt update && apt install -y brave-browser")
os.system("wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg")
os.system('echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main" | sudo tee /etc/apt/sources.list.d/vscodium.list')
os.system("apt update && apt install -y codium")
os.system("apt remove -y plymouth")

print("[INSTALL] Select your bootloader:")
print("1) GRUB")
print("2) systemd-boot")
print("3) LILO")
print("4) rEFInd")
print("5) Other (skips bootloader changes)")
print()

while True:
    bl_choice = input("[INSTALL] Enter the number corresponding to your bootloader: ")
    if bl_choice.isdigit() and 1 <= int(bl_choice) <= 5:
        bl_choice = int(bl_choice)
        break
    else:
        print("[INFO] Invalid selection. Please choose a valid number (1-5).")

if bl_choice == 5:
    print("[INFO] Skipping bootloader changes.")
else:
    if bl_choice == 1:
        os.system('sudo sed -i \'s/^GRUB_DISTRIBUTOR="Ubuntu.*"/GRUB_DISTRIBUTOR="Nexa Linux"/\' /etc/default/grub')
        os.system("sudo grub-mkconfig -o /boot/grub/grub.cfg")
    elif bl_choice == 2:
        os.system('sudo sed -i \'s/Ubuntu.*/Nexa Linux/\' /boot/loader/entries/arch.conf')
        os.system("sudo bootctl update")
    elif bl_choice == 3:
        os.system('sudo sed -i \'s/Ubuntu.*/Nexa Linux/\' /etc/lilo.conf')
        os.system("sudo lilo")
    elif bl_choice == 4:
        os.system('sudo sed -i \'s/Ubuntu.*/Nexa Linux/\' /boot/loader/entries/arch.conf')
        os.system("sudo refind-install")

os.system("rm -rf /tmp/nexa-tmp")
print("[INFO] Cleaned up temporary files")

os.system("clear")
print("Done installing! Please reboot your PC.")
exit(0)
