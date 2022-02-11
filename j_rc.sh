#!/bin/bash

# j_kiosk enable
# j_kiosk disable
# j_kiosk start

j_kiosk() {
	if [ -z "$1" ]
	then #No arguments supplied
		echo "Parameters"
		echo "* enable"
		echo "* disable"
		echo "* start"

	else #arguments
		if [[ "$1" == "enable" ]]
		then
			echo "~~~Enabled j_kiosk~~~"
			echo "Type 'sudo reboot' to enable"

			sudo systemctl enable kiosk.service
		elif [[ "$1" == "disable" ]]
		then
			echo "~~~Disabling kiosk~~~"
			echo "Type 'sudo reboot' to disable"

			sudo systemctl disable kiosk.service
		elif [[ "$1" == "start" ]]
		then
			echo "~~~Starting kiosk~~~"

			sudo systemctl start kiosk.service
		else
			echo "Unknown command: $1"
		fi
	fi
}
