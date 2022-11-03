#!/usr/bin/env python3

from typing import Literal
from gpiozero import LED

def status() -> Literal["on"] | Literal["off"]:
    """Gets the status of the monitor (on or off)"""
    relayPin=LED(14)
    return "on" if relayPin.is_active else "off"

if __name__=='__main__':
    print(status())
