# Quick-n-easy Install
Running the following command will turn a Raspberry Pi into a Buseroo kiosk:
```sh
bash -c "$(curl -L https://buseroo.com/JKiosk/install.sh)"
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
bash -c "$(curl -L https://buseroo.com/JKiosk/install.sh)"
```
The command will take around a minute to run and the kiosk should start displaying the buseroo.com website on your selected institution. If not, check the debugging section below:

<details>
    <summary>
        <b>Debugging problems installing JKiosk</b>
    </summary>
    <ul>
        <li><b>Problem</b>: How to uninstall JKiosk?
        <br/>
        <b>Solution</b>: <code>bash -c "$(curl -L https://buseroo.com/JKiosk/uninstall.sh)"</code>
        </li>
        <li><b>Problem</b>: How to change the specified institution?
        <br/>
        <b>Solution</b>: Uninstall and reinstall JKiosk, specifying the right institution this time.
        </li>
        <li><b>Problem</b>: Get the error message <code>Job for kiosk.service failed because the control process exited with err... See "systemctl status kiosk.services" and "journalctl -xe" for details</code>
        <br/>
        <b>Solution</b>: Run <code>systemctl status kiosk.service</code>. If you get the error <code>Failed to determine group credentials</code>, then the incorrect user group was specified. Uninstall and reinstall JKiosk specifying the <b>correct</b> user group.
        </li>
    </ul>
</details>


<br/>



# How to Use
Type `jkiosk off` to stop the kiosk and `jkiosk on` to restart it.


<br/>



# About the Code
* `kiosk.service` (`/usr/lib/systemd/system/kiosk.service`)
    The kiosk service file specifies kiosk mode configurations for the system daemon such as the environment and where the kiosk.sh file is located.
* `kiosk.sh`
    The kiosk shell file puts the kiosk in kiosk mode when executed. It is called by the system daemon based on kiosk.service's configuration.
* `jkiosk.sh`
    Makes managing the kiosk in the command line easier through simple commands such as `jkiosk on`, `jkiosk off`, `jkiosk status`, and `jkiosk uninstall`. It is sourced from `~/.bashrc` on every shell session startup
