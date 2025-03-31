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

import os

print("[ISO] Removing root password")
os.system("sudo passwd -l root")

print("[ISO] Installing dependencies")
os.system("sudo apt install git tar")

print("[ISO] Making directories")
os.system("mkdir /tmp/prod")
os.system("mkdir /home/root")

print("[ISO] Installing Penguins' eggs")
os.system("git clone https://github.com/pieroproietti/get-eggs /tmp/prod/get-eggs/")
os.system("cd /tmp/prod/get-eggs/ && sudo ./get-eggs.sh")

print("[ISO] Adding wardrobes")
os.system("git clone https://github.com/pieroproietti/penguins-wardrobe /home/root/.wardrobe/")

print("[ISO] Installing Calamares (eggs)")
os.system("sudo eggs calamares --install --theme nexa")

print("[ISO] Running configuration")
os.system("sudo eggs dad")

print("[ISO] Producing an egg!")
os.system("sudo eggs produce --theme nexa --release --noicon")