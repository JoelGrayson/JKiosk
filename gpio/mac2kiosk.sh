#!/bin/bash

# USAGE: ./transfer-file.sh main.py

scp "$1" "kiosk@raspberrypi.local:/home/kiosk/JKiosk/gpio/$1"
