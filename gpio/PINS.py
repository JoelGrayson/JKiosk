PINS={ #when changing here, change executable pins as well
    "button-led": { #indicates if pi has power
        "power":  {'pin': 18},
        "ground": {'pin': 6}
    },
    "button": { #see if button pressed
        "output": {'pin': 8,  "gpio": 14},
        "input":  {'pin': 10, "gpio": 15}
    },
    "monitor": { #turn monitor on/off through relay
        "ground": {'pin': 14},
        "output": {'pin': 16, "gpio": 23}
    }
}
