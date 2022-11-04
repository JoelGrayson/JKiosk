#!/usr/bin/env python3

# This is executable

from gpiozero import InputDevice, OutputDevice, LED
from time import sleep
from monitor import turn_on, turn_off, status

def listen():
    o14=InputDevice(14)
    i15=OutputDevice(15)
    i15.on()
    while True: #Listen
        if o14.is_active: #button pressed (∵ o14-i15 circuit connected)
            curr_status=status() #current monitor status
            if curr_status=="off":
                turn_on()
                sleep(15*60) #turn on for 15 minutes
                turn_off()
            # if curr_status=="on": #already on, so no difference
                # pass

if __name__=='__main__':
    listen()
