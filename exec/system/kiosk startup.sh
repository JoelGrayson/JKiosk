#!/bin/bash

# ABOUT: run when kiosk starts up

sudo systemctl start kiosk.service #turn kiosk mode on
"$HOME/JKiosk/exec/relay/LOW" #turn on monitor

