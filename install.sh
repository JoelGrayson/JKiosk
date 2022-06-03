#!/bin/bash

# Starts up every year
echo "# J_Kiosk
source j_kiosk.sh
" >> ~/.bashrc

# Moves files to correct locations on raspberry pi
sudo cp "$HOME/J_Kiosk/kiosk.service" "/usr/lib/systemd/"
# j_kiosk.sh, kiosk.sh, reboot startup.sh stays
sudo cp "$HOME/J_Kiosk/kiosk.service" "/"
