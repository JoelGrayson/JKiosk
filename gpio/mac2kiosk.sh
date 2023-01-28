#!/bin/bash

# USAGE: ./transfer-file.sh button.py

scp "$1" "kiosk@raspberrypi.local:/home/kiosk/JKiosk/gpio/$1"
