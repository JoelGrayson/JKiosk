# Monitor 
The monitor is plugged into the "normally on" outlet of the relay, so that it is always on even while the pi's GPIO pins aren't on yet. This means sending a HIGH signal, turns off the monitor and a LOW signal keeps the monitor on.

# Schematic
## Button
* pin 6 - ground for the button's LED (white wire)
* pin 8 - GPIO14 for outputing electricity (blue wire)
* pin 10 - GPIO15 for reading electricity to see if button pressed (red wire)
    if read_input()==1, button is pressed (closed circuit)
    if read_input()==0, button is not pressed (open circuit)
* pin 12 - GPIO18 as power to the button's LED (orange wire)
## Monitor
* pin 20 - ground for the monitor
* pin 22 - GPIO25 for outputing electricity to the monitor

![Wiring Diagram](https://i.imgur.com/GbXoAHr.jpeg)

