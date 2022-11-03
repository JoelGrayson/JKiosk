#!/usr/bin/env python3

from gpiozero import LED

def turn_on():
    """sends a LOW signal to the relay, turning the monitor on"""
    relayPin=LED(14)
    relayPin.off()

if __name__=='__main__':
    turn_on()
