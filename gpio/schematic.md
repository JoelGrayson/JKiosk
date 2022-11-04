# Monitor 
The monitor is plugged into the "normally on" outlet of the relay, so that it is always on even while the pi's GPIO pins aren't on yet. This means sending a HIGH signal, turns off the monitor and a LOW signal keeps the monitor on.

# Schematic
pin 4 - power to the button's LED
pin 6 - ground for the button's LED
pin 8 - GPIO14 for outputing electricity
pin 10 - GPIO15 for reading electricity to see if button pressed
    if read_input()==1, button is pressed (closed circuit)
    if read_input()==0, button is not pressed (open circuit)


Wiring Diagram:
![Wiring diagram](https://raw.githubusercontent.com/JoelGrayson/Buseroo/main/designs/raspberry%20pi/button%20listening%20wire%20schematic.jpg)