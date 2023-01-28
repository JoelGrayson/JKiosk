from gpiozero import LED
from PINS import PINS

relay_pin=PINS['monitor']['output']['gpio']
relay=LED(relay_pin)
print(f'Relay is on the gpio pin {relay_pin}.')

def turn_off():
    """sends a HIGH signal to the relay, turning the monitor off"""
    relay.on()

def turn_on():
    """sends a LOW signal to the relay, turning the monitor on"""
    relay.off()

def status(): #-> Literal["on"] | Literal["off"]:
    """Gets the status of the monitor (on or off)"""
    if relay.value==1: #active=HIGH=monitor off
        return "off"
    else:
        return "on"

