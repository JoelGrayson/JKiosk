from gpiozero import LED
from typing import Literal
from PINS import PINS

def turn_off():
    """sends a HIGH signal to the relay, turning the monitor off"""
    relayPin=PINS['monitor']['output']['gpio']
    LED(relayPin).on()

def turn_on():
    """sends a LOW signal to the relay, turning the monitor on"""
    relayPin=PINS['monitor']['output']['gpio']
    LED(relayPin).off()

def status() -> Literal["on"] | Literal["off"]:
    """Gets the status of the monitor (on or off)"""
    relayPin=LED(23)
    return "on" if relayPin.is_active else "off"
