#!/usr/bin/env python3

# ABOUT: This is an executable to be run when the kiosk is operating

from gpiozero import InputDevice, OutputDevice
from time import time, sleep
from monitor import turn_on, turn_off, status, follow_todays_schedule
from PINS import PINS
from should_be_on_now import should_be_on_now
from datetime import date
from button_led import turn_on_button_led, turn_off_button_led

def listen_to_button():
    o15=OutputDevice(PINS['button']['input']['gpio']) #for btn to receive input
    o15.on()
    btn=InputDevice(PINS['button']['output']['gpio']) #read if button pressed

    last_pressed=None #datetime of last button press
    will_turn_off_at=None #for the kiosk to turn itself off after 10 minutes if not supposed to be on according to the schedule
    turning_off_active_started=None #time when the button was first activated to turn off the monitor (hold down button for 3 seconds to turn off the monitor)

    prev_curr_status=None #to see if status changed
    while True: #Listen for button press
        curr_status=status() #current monitor status

        if prev_curr_status!=None and prev_curr_status!=curr_status: #status changed
            if curr_status=="off": #button is on if monitor off
                turn_on_button_led()
            if curr_status=="on": #turn button off
                turn_off_button_led()

        if will_turn_off_at!=None: #turn off if after-hours
            if time()>will_turn_off_at and should_be_on_now()=='off':
                turn_off()
                will_turn_off_at=None

        if turning_off_active_started!=None and time()>turning_off_active_started: #turn off after holding down for three seconds
            if curr_status=="on" and btn.is_active:
                turn_off()
                print('Turned monitor off')
            turning_off_active_started=None
            last_pressed=time()

        if btn.is_active: #button pressed bc btn-o15 circuit connected
            if last_pressed!=None and last_pressed+1>time(): #ignore if btn pressed less than a second ago
                prev_curr_status=status
                continue
            
            last_pressed=time()

            if curr_status=="off": #turn on immediately if currently off
                turn_on()
                print('Turned monitor on')
                turning_off_active_started=None
                if should_be_on_now()=="off":
                    print('Will turn off in 10 minutes because off-hour')
                    will_turn_off_at=time()+10*60 #turn off after 10 minutes of inactivity during after-hours
                
                # Blink for three seconds (because monitor/relay system takes 3 seconds to turn on from off). Tells user that something is happening.
                # Does not accept any other requests while turning on (e.g. turning off)
                turn_off_button_led()
                sleep(0.4)
                for _ in range(4):
                    turn_on_button_led()
                    sleep(0.4)
                    turn_off_button_led()
                    sleep(0.4)

            elif curr_status=="on":
                if turning_off_active_started==None: #trigger turn off after 3 seconds if still holding
                    turning_off_active_started=time()+3 #3 seconds later
            else:
                print('Unknown curr_status:', curr_status)
        
        prev_curr_status=status

if __name__=='__main__':
    print(f'-----Date: {str(date.today())}-----')
    print('Listening to button...')
    follow_todays_schedule()
    listen_to_button()
