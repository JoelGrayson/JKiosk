#!/bin/bash

# ABOUT: Source this file to access `jkiosk` command for controlling `sudo systemctl kiosk.service``
# Created 2.2022
# Last modified on 10.7.22

jkiosk() {
    #* Methods
	jkiosk_help() { #local function not defined outside
		echo "Parameter (such as \`jkiosk enable\`)"
		echo "# Porcelain (high-level commands)"
		echo "  * on - enable & start"
		echo "  * off - stop & disable"
		echo "# Plumbing (low-level)"
		echo "  * enable"
		echo "  * disable"
		echo "  * start"
		echo "  * status"
		echo "# More"
		echo "  * version - show when JKiosk installed"
		echo "  * upgrade - uninstalls & reinstalls"
        echo "  * uninstall"
	}

    version() {
        echo 'JKiosk Version VERSION_INSERTED_HERE_BY_INSTALL_SH'
        echo 'Installed on DATE_INSERTED_HERE_BY_INSTALL_SH'
    }

    on() {
        echo "~~~Turning ON~~~"
        sudo systemctl enable kiosk.service
        sudo systemctl start kiosk.service
    }

    off() {
        echo "~~~Turning OFF~~~"
        
        echo "Stopping"
        sudo systemctl stop kiosk.service
        sleep 3
        
        echo "Disabling"
        sudo systemctl disable kiosk.service
    }

    enable() { #pi enters kiosk mode on boot
        echo "~~~Enabled kiosk~~~"
        echo "Now, pi will go into kiosk mode when booting."

        sudo systemctl enable kiosk.service
    }

    disable() { #pi does not enter kiosk mode on boot
        echo "~~~Disabling kiosk~~~"
        echo "Now, pi will no longer go into kiosk mode when booting."

        sudo systemctl disable kiosk.service
    }

    start() { #start kiosk mode now
        echo "~~~Starting kiosk~~~"

        sudo systemctl start kiosk.service
    }

    stop() { #stop current kiosk mode
        echo "~~~Stopping kiosk~~~"
        echo "Kiosk mode off for now."

        sudo systemctl stop kiosk.service
    }

    status() {
        echo "~~~Getting Status of kiosk.service~~~"
        sudo systemctl status kiosk.service
    }

    uninstall() {
        echo '~~~Uninstalling JKiosk from this Raspberry Pi~~~'
        bash -c "$(curl -L http://buseroo.com/JKiosk/uninstall.sh)"
    }

    upgrade() {
        echo '~~~Upgrading JKiosk from VERSION_INSERTED_HERE_BY_INSTALL_SH to latest~~~'

        bash -c "$(curl -L http://buseroo.com/JKiosk/uninstall.sh)"
        bash -c "$(curl -L http://buseroo.com/JKiosk/install.sh)"
    }



    #* Connect Methods
    called=false

    # Help
	[ -z "$1" ] || [ "$1" = 'help' ] && called=true && jkiosk_help

    # Porcelain
    [ "$1" = "on" ]  && called=true && on
    [ "$1" = "off" ] && called=true && off

    # Plumbing
    [ "$1" = "enable" ]    && called=true && enable
    [ "$1" = "disable" ]   && called=true && disable
    [ "$1" = "start" ]     && called=true && start
    [ "$1" = "stop" ]      && called=true && stop
    [ "$1" = "status" ]    && called=true && status
    [ "$1" = "version" ] && called=true && version
    [ "$1" = "upgrade" ] || [ "$1" = "update" ] && called=true && upgrade
    [ "$1" = "uninstall" ] && called=true && uninstall
	

    # If no command was triggered
    ! $called && echo "Unknown command: $1
Type \`jkiosk help\` for a full list of commands"

}
