#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

# Source j_kiosk every startup
echo "# J_Kiosk
source j_kiosk.sh
" >> ~/.bashrc

# Moves files to correct locations on raspberry pi
sudo cp "$HOME/J_Kiosk/kiosk.service" "/usr/lib/systemd/"
# j_kiosk.sh, kiosk.sh, reboot startup.sh stays
sudo cp "$HOME/J_Kiosk/kiosk.service" "/"

crontab cronjobs #sets cronjobs as the new crontab

# Apt packages
sudo apt install -y vim #for syntax highlighting
sudo apt purge wolfram-engine scratch nuscratch #remove unnecessary packages
sudo apt-get install nodejs

# Git
git config --global user.name "Joel Grayson"
git config --global user.email joel@joelgrayson.com


echo """
Finish setting up:
1. Set the splash screen with the Raspi GUI.
2. sudo reboot

"""