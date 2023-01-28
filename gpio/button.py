#!/usr/bin/env python3

# ABOUT: This is an executable to be run when the kiosk is operating

from gpiozero import InputDevice, OutputDevice, LED
from time import sleep, time
from monitor import turn_on, turn_off, status
from PINS import PINS

def listen():
    o15=OutputDevice(PINS['button']['input']['gpio']) #for btn to receive input
    o15.on()
    btn=InputDevice(PINS['button']['output']['gpio']) #read if button pressed

    last_pressed=None #datetime of last button press
    
    while True: #Listen for button press
        curr_status=status() #current monitor status

        if curr_status=="off": #button is on if monitor off
            LED(PINS['button-led']['power']['gpio']).on()

        if btn.is_active: #button pressed (∵ btn circuit connected)
            if last_pressed is not None and last_pressed+1>time(): continue #ignore if btn pressed less than a second ago
            
            last_pressed=time()

            if curr_status=="off":
                turn_on()
                print('Turned monitor on')
                # TODO: turn off after 15 minutes of inactivity during after-hours
            if curr_status=="on": #already on, so no difference
                turn_off()
                print('Turned monitor off')

if __name__=='__main__':
    print('Listening to button...')
    listen()

