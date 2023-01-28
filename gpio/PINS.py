PINS={ #when changing here, change executable pins as well
    'button': { #see if button pressed
        'output': { 'pin': 8,  'gpio': 14 },
        'input':  { 'pin': 10, 'gpio': 15 }
    },
    'button-led': { #indicates if pi has power
        'ground': { 'pin': 6 },
        'power':  { 'pin': 12, 'gpio': 18 }
    },
    'monitor': { #turn monitor on/off through relay
        'ground': { 'pin': 20 },
        'output': { 'pin': 22, 'gpio': 25 }
    }
}
