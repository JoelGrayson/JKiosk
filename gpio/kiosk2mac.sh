#!/bin/bash

# USAGE: ./transfer-file.sh button.py

scp "$1" "joelgrayson@joelgrayson.local:/Users/joelgrayson/Desktop/Software/buseroo/JKiosk/gpio/$1"
