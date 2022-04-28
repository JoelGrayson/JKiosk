#!/bin/bash

# j_kiosk enable
# j_kiosk disable
# j_kiosk start

j_kiosk() {
	j_kiosk_help() { #local function not defined outside
		echo 'Parameter (such as `j_kiosk enable`)'
		echo "# Porcelain (high-level commands)"
		echo "* on - enable & start"
		echo "* off - disable, stop, & reboot"
		echo "# Plumbing (low-level)"
		echo "* enable"
		echo "* disable"
		echo "* start"
		echo "* status"
		echo "* js (options node interactive version)"
	}

	if [ -z "$1" ]
	then #No arguments supplied
		j_kiosk_help
	
	else #arguments
		# Porcelain
		if [[ "$1" == "on" ]]
		then
			echo "~~~Turning ON~~~"
			sudo systemctl enable kiosk.service
			sudo systemctl start kiosk.service
		elif [[ "$1" == "off" ]]
		then
			echo "~~~Turning OFF~~~"
			
			echo "Disabling"
			sudo systemctl disable kiosk.service
			echo "Stopping"
			sleep 3
			sudo systemctl stop kiosk.service
			echo "Rebooting"
			sleep 3
			sudo reboot
		# Plumbing
		elif [[ "$1" == "enable" ]]
		then
			echo "~~~Enabled j_kiosk~~~"
			echo 'Type `sudo reboot` to disable'

			sudo systemctl enable kiosk.service
		elif [[ "$1" == "disable" ]]
		then
			echo "~~~Disabling kiosk~~~"
			echo 'Type `sudo reboot` to disable'

			sudo systemctl disable kiosk.service
		elif [[ "$1" == "start" ]]
		then
			echo "~~~Starting kiosk~~~"

			sudo systemctl start kiosk.service
		elif [[ "$1" == "status" ]]
		then
			echo "~~~Getting Status of kiosk.service~~~"

			sudo systemctl status kiosk.service
		elif [[ "$1" == "stop" ]]
		then
			echo "~~~Stopping kiosk~~~"

			sudo systemctl stop kiosk.service
		elif [[ "$1" == "help" ]]
		then
			j_kiosk_help
		elif [[ "$1" == "js" ]]
		then
			node /home/pi/J_Kiosk/j_rc\ node/j_kiosk.js #runs interactive version of j_kiosk javascript
		else
			echo "Unknown command: $1"
			echo 'Type `j_kiosk help` for full commands'
		fi
	fi
}