#!/bin/bash
# ABOUT: This file is located at https://buseroo.com/JKiosk/uninstall.sh
# Last updated 10.7.22
# Created 10.7.22

section() { # print out sections
    printf "\n$(tput setaf 2)----- %s -----$(tput sgr0)\n\n" "$1"
}

section 'Removing JKiosk'

rm -rf "$HOME/JKiosk"

section 'Restoring Desktop Wallpaper'
# Restore backup plymouth theme
WALLPAPER='/usr/share/plymouth/themes/pix/splash.png'
sudo rm "$WALLPAPER"
if [ -e "$WALLPAPER.bak" ]; then
    sudo mv "$WALLPAPER.bak" "$WALLPAPER"
else
    echo 'Select wallpaper from rdp-wallpaper'
    pcmanfm '/usr/share/rdp-wallpaper'
fi
pcmanfm --set-wallpaper "$WALLPAPER"


section 'Remaining Steps to do Manually below:'

echo '1. Remove #jkiosk line from bashrc'

