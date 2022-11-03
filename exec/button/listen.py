#!/usr/bin/env python3

from gpiozero import InputDevice, OutputDevice, LED
from time import sleep
from ..monitor import turn_on, turn_off, status

"""
# Schematic
pin 4 - power to the button's LED
pin 6 - ground for the button's LED
pin 8 - GPIO14 for outputing electricity
pin 10 - GPIO15 for reading electricity to see if button pressed
    if read_input()==1, button is pressed (closed circuit)
    if read_input()==0, button is not pressed (open circuit)

See image of wiring at https://raw.githubusercontent.com/JoelGrayson/Buseroo/main/designs/raspberry%20pi/button%20listening%20wire%20schematic.jpg
"""

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
