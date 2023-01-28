from gpiozero import LED
from PINS import PINS
import os
import subprocess

relay_pin=PINS['monitor']['output']['gpio']
relay=LED(relay_pin)
print(f'Relay is on the gpio pin {relay_pin}.')

def turn_off():
    """sends a HIGH signal to the relay, turning the monitor off"""
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-off-monitor')

def turn_on():
    """sends a LOW signal to the relay, turning the monitor on"""
    # relay.off()
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-on-monitor')

def status(): #-> Literal["on"] | Literal["off"]:
    """Gets the status of the monitor (on or off)"""
    # if relay.value==1: #active=HIGH=monitor off
    #     return "off"
    # else:
    #     return "on"
    return subprocess.check_output('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/monitor-status').decode().strip()
