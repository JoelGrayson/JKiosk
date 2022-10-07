# Quick-n-easy Install
Running the following command will turn a Raspberry Pi into a Buseroo kiosk:
```sh
bash -c "$(curl -L http://buseroo.com/jkiosk/install.sh)"
```



# JKiosk
# Entry Point
/.bashrc -> JKiosk.sh (have JKiosk command)
@reboot in crontab -> JKiosk (JKiosk on)

## How To Use
```bash
JKiosk enable
JKiosk start
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
Calls the JKiosk.sh

#### JKiosk.sh
Has custom commands to make command line kiosk management easier such as `JKiosk`


# Background Splash Screen
* GUI add in desktop preferences
* /usr/share/plymouth/themes/pix/splash.png for system
