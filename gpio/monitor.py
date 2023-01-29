import os
import subprocess

def turn_off():
    """sends a HIGH signal to the relay, turning the monitor off"""
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-off-monitor')

def turn_on():
    """sends a LOW signal to the relay, turning the monitor on"""
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-on-monitor')

def status(): #-> Literal["on"] | Literal["off"]:
    """Gets the status of the monitor (on or off)"""
    return subprocess.check_output('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/monitor-status').decode().strip()

def follow_todays_schedule():
    """Turns monitor on or off based on today's schedule"""
    os.system('BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-on-monitor')
