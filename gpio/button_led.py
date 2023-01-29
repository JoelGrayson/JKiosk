import os

def turn_on_button_led():
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/button-led/turn-on')

def turn_off_button_led():
    """sends a LOW signal to the relay, turning the monitor on"""
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/button-led/turn-off')
