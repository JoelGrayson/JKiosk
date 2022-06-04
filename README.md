# Entry Point
/.bashrc -> j_kiosk.sh (have j_kiosk command)
@reboot in crontab -> j_kiosk (j_kiosk on)


# J_Kiosk
## How To Use
```bash
j_kiosk enable
j_kiosk start
#if necessary, sudo reboot
```


## About This File & Directory
This file and directory contains what I have configured on the Raspberry Pi OS. It includes files and aliases to other system files. This file describes the usage of each file.

### Necessary For Kiosk
#### Kiosk.service (/usr/lib/systemd/system/kiosk.service)
This file is located at /usr/lib/systemd/system/kiosk.service
Kiosk service file (kiosk.service) has information about kiosk mode such as the environment as well as where the kiosk.sh file is.

#### kiosk.sh
Kiosk shell file has configuration about the Raspi kiosk mode.
It is called by the kiosk.service file.

#### reboot startup.sh
Called by the cronjob when reopening kiosk.


### Syntactic Sugar
#### ~/.bashrc
Calls the j_kiosk.sh

#### j_kiosk.sh
Has custom commands to make command line kiosk management easier such as `j_kiosk`


# Background Splash Screen
* GUI add in desktop preferences
* /usr/share/plymouth/themes/pix/splash.png for system
