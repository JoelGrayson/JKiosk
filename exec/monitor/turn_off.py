#!/usr/bin/env python3

from gpiozero import LED

def turn_off():
    """sends a HIGH signal to the relay, turning the monitor off"""
    relayPin=LED(14)
    relayPin.on()

if __name__=='__main__':
    turn_off()
