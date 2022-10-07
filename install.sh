#!/bin/bash
# ABOUT: This file is located at https://buseroo.com/JKiosk/install.sh
# Last updated 10.7.22
# Created 11.2021

section() { # print out sections
    printf "\n$(tput setaf 2)----- %s -----$(tput sgr0)\n\n" "$1"
}

ERR() {
    echo "[ERR] $1"
    exit 65
}
WARN() {
    echo "[WARN] $1"
}

# Check if JKiosk already exists
[ -d "$HOME/JKiosk" ] && ERR 'JKiosk already installed'


# Preparing
section '1. Preparing'
sudo apt-get update
sudo apt-get upgrade -y
sudo apt purge -y wolfram-engine scratch scratch2 nuscratch libreoffice* #remove unnecessary packages
sudo apt clean -y
sudo apt autoremove -y
sudo apt-get install -y vim xdotool unclutter sed #install needed packages

# Get JKiosk from GitHub
section '2. JKiosk from GitHub'
git clone https://github.com/JoelGrayson/JKiosk.git || ERR 'Could not clone git repository'
BASE="$HOME/JKiosk"
cd "$BASE" || ERR 'Could not install JKiosk properly'

# Moves files to correct locations
section '3. Processing JKiosk Files'
sudo cp "$BASE/exec/system/kiosk.service" "/usr/lib/systemd/" || ERR "can't move kiosk.service"
crontab "$BASE/exec/system/cronjobs" #sets cronjobs as the new crontab so turns on/off at right times and turns on kiosk on boot

# Make files executable
chmod +x "$BASE/exec/system/kiosk.sh"
chmod +x "$BASE/exec/system/kiosk startup.sh"
chmod +x "$BASE/exec/system/JKiosk.sh"
chmod +x "$BASE/exec/relay/HIGH"
chmod +x "$BASE/exec/relay/LOW"


section '4. Setting Wallpaper and Splash Screen'
# Set splash screen for when raspberry pi is booting
SPLASH_DIR="/usr/share/plymouth/themes/pix"
sudo mv "$SPLASH_DIR/splash.png" "$SPLASH_DIR/splash.png.bak" #backup splash saver
sudo cp "$BASE/theme/splash.png" "$SPLASH_DIR/splash.png"

# Set desktop wallpaper
sudo unlink /etc/alternatives/desktop-background #these two lines should do it in other versions
sudo ln -s "$BASE/themes/desktop background.png" /etc/alternatives/desktop-background
pcmanfm --set-wallpaper "$BASE/theme/desktop background.png" #this usu does it in my raspis


section '5. Enabling kiosk mode'
sudo systemctl enable kiosk.service #means the kiosk will automatically turn into kiosk mode on reboot


section '6. Finishing Up'

# Source JKiosk.sh on every terminal window opened (session startup)
grep -q '# JKiosk' < "$HOME/.bashrc" && WARN "There are duplicate records of JKiosk in ~/.bashrc. Remove one."
echo "
# JKiosk
source '$BASE/exec/system/JKiosk.sh'
" >> "$HOME/.bashrc"


# Git
git config --global user.name "Joel Grayson"
git config --global user.email joel@joelgrayson.com

# Fin
echo "Finished setting up. Run \`sudo reboot\` when you are ready."
