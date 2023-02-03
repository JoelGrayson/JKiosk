#!/bin/bash

# ABOUT: when executed, puts the file in kiosk mode
# created on 10.7.21
# last modified on 2.2.23

xset s noblank
xset s off
xset -dpms

hide_cursor_after_seconds=0.1 # if 0, no cursor. Otherwise, hides cursor after ${} seconds

unclutter -idle $hide_cursor_after_seconds -root &

# Avoids chromium from showing errors
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' HOME_INSERTED_HERE_BY_INSTALL_SH/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' HOME_INSERTED_HERE_BY_INSTALL_SH/.config/chromium/Default/Preferences

# Launches Chromium with params
/usr/bin/chromium-browser --window-size=1920,1080 --kiosk --disable-overlay-scrollbar --noerrdialog --disable-infobars --start-fullscreen --disable-print-preview --kiosk-printing --window-position=0,0 --app=https://buseroo.com/app/kiosk?institution=INSTITUTION_INSERTED_HERE_BY_INSTALL_SH &
