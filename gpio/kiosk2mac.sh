#!/bin/bash

# USAGE: ./transfer-file.sh main.py

scp "$1" "joelgrayson@joelgrayson.local:/Users/joelgrayson/Desktop/Software/buseroo/JKiosk/gpio/$1"
