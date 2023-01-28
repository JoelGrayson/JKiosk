#!/usr/bin/env python3

# This is executable

from gpiozero import InputDevice, OutputDevice, LED
from time import sleep, time
from monitor import turn_on, turn_off, status
from PINS import PINS

def listen():
    o14=InputDevice(14)
    i15=OutputDevice(15)
    i15.on()

    turn_on()

    last_pressed=None #datetime of last button press
    
    while True: #Listen
        if o14.is_active: #button pressed (∵ o14-i15 circuit connected)
            if last_pressed is not None and last_pressed+1>time(): continue #ignore if btn pressed less than a second ago
            
            curr_status=status() #current monitor status

            print('Pressed button')
            last_pressed=time()

            if curr_status=="off":
                print('Turning off')
                turn_on()
                #sleep(15*60) #turn on for 15 minutes
                #turn_off()
            if curr_status=="on": #already on, so no difference
                print('Turning on')
                turn_off()

if __name__=='__main__':
    print('Listening to button...')
    listen()
