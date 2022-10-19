# Quick-n-easy Install
Running the following command will turn a Raspberry Pi into a Buseroo kiosk:
```sh
bash -c "$(curl -L http://buseroo.com/JKiosk/install.sh)"
```






# Full Install Instructions
**Install Raspberry Pi**
    1. Download the Raspberry Pi Imager from https://www.raspberrypi.com/software/
    2. Install Raspberry Pi OS onto a MicroSD card through the Imager.
    3. Attach the MicroSD card, a touch screen, keyboard, and mouse to the Raspberry Pi.
    4. Power up the kiosk and follow the setup instructions on screen.
**Install JKiosk**
5. Once the instructions are finished and the kiosk has rebooted, install JKiosk by running the following command:
```sh
bash -c "$(curl -L http://buseroo.com/JKiosk/install.sh)"
```

<details>
    <summary>
        Debugging problems with installing JKiosk
    </summary>
    <ul>
        <li><b>Problem</b>: How to uninstall JKiosk?
        <br/>
        <b>Solution</b>: <code>bash -c "$(curl -L http://buseroo.com/JKiosk/uninstall.sh)"</code>
        </li>
        <li><b>Problem</b>: Get the error message <code>Job for kiosk.service failed because the control process exited with err... See "systemctl status kiosk.services" and "journalctl -xe" for details</code>
        <br/>
        <b>Solution</b>: Run <code>systemctl status kiosk.service</code>. If you get the error <code>Failed to determine group credentials</code>, then the incorrect user group was specified. Uninstall and reinstall JKiosk specifying the <b>correct</b> user group.
        </li>
    </ul>
</details>








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
