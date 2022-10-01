#!/bin/bash
# ABOUT: This file is located at https://buseroo.com/JKiosk/install.sh

# Preparing
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y vim nodejs rpi.gpio #for syntax highlighting
sudo apt purge wolfram-engine scratch scratch2 nuscratch minecraft-pi libreoffice* penguinspuzzle #remove unnecessary packages
sudo apt clean
sudo apt autoremove -y


# Get JKiosk from GitHub
cd "$HOME" || exit 1
git clone https://github.com/JoelGrayson/JKiosk.git
BASE="$HOME/JKiosk"
cd "$BASE" || echo "[ERR] Could not install JKiosk properly" && exit 1

# Moves files to correct locations
sudo cp "$BASE/exec/system/kiosk.service" "/usr/lib/systemd/"
crontab "$BASE/exec/system/cronjobs" #sets cronjobs as the new crontab

# Make files executable
chmod +x "$BASE/exec/system/kiosk.sh"
chmod +x "$BASE/exec/system/kiosk startup.sh"
chmod +x "$BASE/exec/system/JKiosk.sh"
chmod +x "$BASE/exec/relay/HIGH"
chmod +x "$BASE/exec/relay/LOW"

# Splash screen
SPLASH_DIR="/usr/share/plymouth/themes/pix"
sudo mv "$SPLASH_DIR/splash.png" "$SPLASH_DIR/splash.png.bak" #backup splash saver
sudo cp "$BASE/exec/system/splash.png" "$SPLASH_DIR/splash.png"


# Source JKiosk.sh on every session startup
echo "
# JKiosk
source \"$HOME/exec/system/JKiosk.sh\"
" >> ~/.bashrc


# Git
git config --global user.name "Joel Grayson"
git config --global user.email joel@joelgrayson.com


# Fin
echo "Finished setting up. Run \`sudo reboot\` when you are ready."
