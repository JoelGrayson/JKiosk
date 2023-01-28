#!/usr/bin/env python3

# ABOUT: This is an executable to be run when the kiosk is operating

from gpiozero import InputDevice, OutputDevice, LED
from time import sleep, time
from monitor import turn_on, turn_off, status
from PINS import PINS
from should_be_on_now import should_be_on_now

def listen():
    o15=OutputDevice(PINS['button']['input']['gpio']) #for btn to receive input
    o15.on()
    btn=InputDevice(PINS['button']['output']['gpio']) #read if button pressed

    last_pressed=None #datetime of last button press
    will_turn_off_at=None
    
    while True: #Listen for button press
        curr_status=status() #current monitor status

        if curr_status=="off": #button is on if monitor off
            LED(PINS['button-led']['power']['gpio']).on()

        if will_turn_off_at!=None: #turn off if after-hours
            if time()>will_turn_off_at and not should_be_on_now():
                turn_off()
                will_turn_off_at=None

        if btn.is_active: #button pressed ∵ btn-o15 circuit connected
            if last_pressed!=None and last_pressed+1>time(): continue #ignore if btn pressed less than a second ago
            
            last_pressed=time()

            if curr_status=="off":
                turn_on()
                print('Turned monitor on')
                if not should_be_on_now():
                    will_turn_off_at=time()+10*60 #turn off after 10 minutes of inactivity during after-hours
            elif curr_status=="on": #already on, so no difference
                turn_off()
                print('Turned monitor off')
            else:
                print('Unknown curr_status:', curr_status)

if __name__=='__main__':
    print('Listening to button...')
    listen()
