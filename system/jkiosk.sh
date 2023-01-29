#!/bin/bash

# ABOUT: Source this file to access `jkiosk` command for controlling the kiosk
# Created 2.2022
# Last modified 1.29.23

jkiosk() {
    # <TOC>:
    #    Defining Methods
    #    Exposing Methods
    # </TOC>

    #* Defining Methods
	help() { #local function not defined outside
		echo "Parameter (such as \`jkiosk enable\`)"
		echo "# Control Kiosk"
		echo "  * on - enable & start"
		echo "  * off - stop & disable"
		echo "## Control Kiosk Low-Level"
		echo "  * enable"
		echo "  * disable"
		echo "  * start"
		echo "  * status"
        echo ""
        echo "# Scheduling"
        echo "  * schedule - show schedule for today"
        echo "  * delete-schedule - cancel any turn on/off commands for today"
        echo ""
        echo "# Monitor"
        echo "  * turn-on-monitor"
        echo "  * turn-off-monitor"
        echo "  * monitor-status"
        echo "  * follow-todays-schedule - turns on/off based on the schedule"
        echo ""
		echo "# JKiosk"
		echo "  * version - show when JKiosk installed"
		echo "  * reinstall"
        echo "  * uninstall"
	}

    # Control Kiosk
    on() {
        echo "~~~Turning ON~~~"
        sudo systemctl enable kiosk.service
        sleep 3
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
    ## Control Kiosk Low-Level
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

    # Scheduling
    schedule() {
        atq
    }

    delete_schedule() {
        atrm
    }

    # Monitor
    turn_on_monitor() {
        echo "~~~Turning on monitor~~~"
        BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-on-monitor
    }

    turn_off_monitor() {
        echo "~~~Turning off monitor~~~"
        BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/turn-off-monitor
    }

    monitor_status() {
        echo "~~~Getting monitor status~~~"
        BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/monitor-status
    }
    
    follow_todays_schedule() { #turns monitor on or off based on today's schedule
        echo "~~~Following today's schedule~~~"
        BASE_INSERTED_HERE_BY_INSTALL_SH/gpio/exec/follow-todays-schedule
    }
    
    # JKiosk
    version() {
        echo 'JKiosk Version VERSION_INSERTED_HERE_BY_INSTALL_SH'
        echo 'Installed on DATE_INSERTED_HERE_BY_INSTALL_SH'
    }

    uninstall() {
        echo '~~~Uninstalling JKiosk from this Raspberry Pi~~~'
        bash -c "$(curl -L http://buseroo.com/JKiosk/uninstall.sh)"
    }

    reinstall() {
        echo '~~~Reinstalling JKiosk from VERSION_INSERTED_HERE_BY_INSTALL_SH to latest~~~'

        printf "\n\n\n-----Uninstalling-----\n\n\n"
        bash -c "$(curl -L http://buseroo.com/JKiosk/uninstall.sh)"
        printf "\n\n\n-----Installing-----\n\n\n"
        bash -c "$(curl -L http://buseroo.com/JKiosk/install.sh)"
        sudo reboot
    }


    #* Exposing Methods
    called=false

    # Help if no parameters or `help` is the parameter
	[ -z "$1" ] || [ "$1" = 'help' ]     && called=true && help

    # Control Kiosk
    [ "$1" = "on" ]                      && called=true && on
    [ "$1" = "off" ]                     && called=true && off
    ## Control Kiosk Low-Level
    [ "$1" = "enable" ]                  && called=true && enable
    [ "$1" = "disable" ]                 && called=true && disable
    [ "$1" = "start" ]                   && called=true && start
    [ "$1" = "stop" ]                    && called=true && stop
    [ "$1" = "status" ]                  && called=true && status

    # Scheduling
    [ "$1" = "schedule" ]                && called=true && schedule
    [ "$1" = "delete-schedule" ]         && called=true && delete_schedule

    # Monitor
    [ "$1" = "turn-on-monitor" ]         && called=true && turn_on_monitor
    [ "$1" = "turn-off-monitor" ]        && called=true && turn_off_monitor
    [ "$1" = "monitor-status" ]          && called=true && monitor_status
    [ "$1" = "follow-todays-schedule" ]  && called=true && follow_todays_schedule

    # JKiosk
    [ "$1" = "version" ]                 && called=true && version
    [ "$1" = "reinstall" ]               && called=true && reinstall
    [ "$1" = "uninstall" ]               && called=true && uninstall
    
    # If no command was triggered
    ! $called && echo "Unknown command: $1
Type \`jkiosk help\` for a full list of commands" && exit 1
}

jkiosk_autocomplete() {
    if [ "$COMP_CWORD" = "1" ]; then #first command is filled in by commands
        local available_options="on off enable disable start status schedule delete-schedule turn-on-monitor turn-off-monitor monitor-status follow-todays-schedule version reinstal uninstall"
            # "on" "off"
            # "enable" "disable" "start" "status"
            # "schedule" "delete-schedule"
            # "turn-on-monitor" "turn-off-monitor" "monitor-status" "follow-todays-schedule"
            # "version" "reinstal" "uninstall"
        COMPREPLY=( $(compgen -W "$available_options" "${COMP_WORDS[1]}") )
    else #second argument filled in by files
        COMPREPLY=( $(ls) )
    fi
}

complete -F jkiosk_autocomplete jkiosk
