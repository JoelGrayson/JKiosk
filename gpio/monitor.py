from gpiozero import LED
from PINS import PINS

relay_pin=PINS['monitor']['output']['gpio']
print(f'Relay is on the gpio pin {relay_pin}.')
relay=LED(relay_pin)
button_led=LED(PINS['button-led']['power']['pin'])

def turn_off():
    """sends a HIGH signal to the relay, turning the monitor off"""
    relay.on()
    button_led.on() #button is on when the monitor is off to indicate that it is ready to be pressed

def turn_on():
    """sends a LOW signal to the relay, turning the monitor on"""
    relay.off()
    button_led.off()

def status(): #-> Literal["on"] | Literal["off"]:
    """Gets the status of the monitor (on or off)"""
    if relay.value==1: #active=HIGH=monitor off
        return "off"
    else:
        return "on"

