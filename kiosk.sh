#!bin/bash

#created in 7.23.21
#last modified in 12.9.21

#about file: when executed, puts the file in kiosk mode

xset s noblank
xset s off
xset -dpms

hide_cursor_after_seconds=0 #if 0, no cursor. Otherwise, hides cursor after ${} seconds
unclutter -idle $hide_cursor_after_seconds -root &

#avoids chromium from showing errors
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

#launches Chromium with params
/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk https://businfokiosk.com/kiosk &
