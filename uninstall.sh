#!/bin/bash
# ABOUT: This file is located at https://buseroo.com/JKiosk/uninstall.sh
# Last updated 10.7.22
# Created 10.7.22

section() { # print out sections
    printf "\n$(tput setaf 2)----- %s -----$(tput sgr0)\n\n" "$1"
}

section 'Removing JKiosk'
rm -rf "$HOME/JKiosk"


section 'Turn off Kiosk Mode'
sudo systemctl disable kiosk.service


section 'Restoring Desktop Wallpaper'
WALLPAPER='/usr/share/plymouth/themes/pix/splash.png'
sudo rm "$WALLPAPER"
if [ -e "$WALLPAPER.bak" ]; then #use backup
    sudo mv "$WALLPAPER.bak" "$WALLPAPER"
    pcmanfm --set-wallpaper "$WALLPAPER"
else #user picks
    echo 'Select wallpaper from rpd-wallpaper'
    pcmanfm '/usr/share/rpd-wallpaper' #open in file manager
fi


section 'Remaining Steps to do Manually below:'
grep '# JKiosk' < ~/.bashrc && echo 'Remove # JKiosk line from ~/.bashrc'
echo 'Run \`sudo reboot\` when ready'

