#!/bin/bash
# ABOUT: This file is located at http://buseroo.com/JKiosk/install.sh
# Last updated 11.5.22
# Created 11.2021

VERSION="1.1"

#* Helpers
section() { # print out sections
    printf "\n$(tput setaf 2)----- %s -----$(tput sgr0)\n\n" "$1"
}

ERR() {
    echo "$(tput setaf 9)[ERR]$(tput sgr0) $1"
    exit 65
}

WARN() {
    echo "$(tput setaf 3)[WARN]$(tput sgr0) $1"
}

command_exists() {
    command -v "$*" &> /dev/null
    return $?
}



#* Check if JKiosk already exists
[ -d "$HOME/JKiosk" ] && ERR 'JKiosk already installed'






section '1. Preparing'

sudo apt-get update
sudo apt-get upgrade -y
sudo apt purge -y smartsim java-common wolfram-engine scratch nuscratch #remove unnecessary packages
# sudo apt purge -y libreoffice* scratch2 remove other unnecessary packages
sudo apt clean -y
sudo apt autoremove -y
sudo apt-get install -y unclutter sed at vim #install needed packages
    # `sed` for kiosk.service parsing
    # `unclutter` to hide the cursor
    # `at` for get-todays-schedule.js

# <gum> Install gum for question
if ! command_exists 'gum' #gum does not exist
then
    echo "Installing gum package"
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt-get install gum
    sleep 1
fi
# install node
sudo curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt-get install -y nodejs

# </gum>





section '2. Select Your Institution'

# Hard-coded for now
institutions='Riverdale Country School
Fieldston
Horace Mann'
# Choices from API
    # Format of API response:
    # 'Riverdale Country School (newline)
    # Fieldston
    # Horace Mann'
# institutions="$(curl https://buseroo.com/api/institutions)"

default_institution='Riverdale Country School'
institution="$default_institution"
if command_exists "gum"; then
    # Backup institution
    institution="$(echo "$institutions" | gum filter || echo "$default_institution")"
else
    # If gum does not exist, use read
    echo "Here are the available institutions:"
    echo "$institutions"
    institution="$(read -pr "Select your institution: ")"
fi
[ -z "$institution" ] && institution="$default_institution" #default
echo "Selected \"$(tput bold)$institution$(tput sgr0)\" as institution."





section '3. What Group Are You?'
printf '\nHere are a list of all the groups:\n%s\n' "$(groups)"
the_prompt="What group is this user in (probably $(whoami))? "
user_group="$(whoami)"
if command_exists "gum"; then
    user_group="$(gum input --prompt "$the_prompt")"
else
    echo "$the_prompt"
    user_group="$(read -r)"
fi
[ -z "$user_group" ] && user_group="$(whoami)" #default value
echo "Using the group: $user_group"






section '4. Clone JKiosk from GitHub'

git clone https://github.com/JoelGrayson/JKiosk.git || ERR 'Could not clone git repository'
BASE="$HOME/JKiosk"
cd "$BASE" || ERR 'Could not install JKiosk properly'





section '5. Expanding *_INSERTED_HERE_BY_INSTALL_SH Values' # Filling in values in files because they cannot expand values such as ~ or $(whoami)
# $*_INSERTED_HERE_BY_INSTALL_SH variables are expanded in the install script.
# HOME_* is $HOME or ~
# BASE_* is the path of the kiosk.sh file
# USERNAME_* is the $(whoami) value
# GROUP_* is the user group specified by the user in a prompt
eEnd="INSERTED_HERE_BY_INSTALL_SH" #expansion end
USERNAME=$(whoami)
GROUP="$user_group"
INSTITUTION="$institution"
DATE="$(date)"

sed -i "s;HOME_$eEnd;$HOME;g"               "$BASE/system/kiosk.service" #; separator so path (/) not confused with separator
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/system/kiosk.service"
sed -i "s;USERNAME_$eEnd;$USERNAME;g"       "$BASE/system/kiosk.service"
sed -i "s;GROUP_$eEnd;$GROUP;g"             "$BASE/system/kiosk.service" #user specified group earlier
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/system/cronjobs"
sed -i "s;HOME_$eEnd;$HOME;g"               "$BASE/system/kiosk.sh"
sed -i "s;INSTITUTION_$eEnd;$INSTITUTION;g" "$BASE/system/kiosk.sh"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/system/jkiosk.sh"
sed -i "s;DATE_$eEnd;$DATE;g"               "$BASE/system/jkiosk.sh"
sed -i "s;VERSION_$eEnd;$VERSION;g"         "$BASE/system/jkiosk.sh"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/system/get-todays-schedule.js"
sed -i "s;INSTITUTION_$eEnd;$INSTITUTION;g" "$BASE/system/get-todays-schedule.js"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/gpio/should_be_on_now.py"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/gpio/monitor.py"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/gpio/exec/follow-todays-schedule"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/gpio/button_led.py"
sed -i "s;HOME_$eEnd;$HOME;g"               "$BASE/logs/inserted-here-by-install-sh.txt"
sed -i "s;BASE_$eEnd;$BASE;g"               "$BASE/logs/inserted-here-by-install-sh.txt"
sed -i "s;USERNAME_$eEnd;$USERNAME;g"       "$BASE/logs/inserted-here-by-install-sh.txt"
sed -i "s;GROUP_$eEnd;$GROUP;g"             "$BASE/logs/inserted-here-by-install-sh.txt"




section '6. Processing JKiosk Files' # Moves files to correct locations

sudo cp "$BASE/system/kiosk.service" "/lib/systemd/system/kiosk.service" || ERR "can't move kiosk.service"
crontab "$BASE/system/cronjobs" #sets cronjobs as the new crontab so turns on/off at right times and turns on kiosk on boot

# Authorize executables
chmod +x "$BASE/system/kiosk.sh"
chmod +x "$BASE/system/jkiosk.sh"
chmod +x "$BASE/system/get-todays-schedule.js"
chmod +x "$BASE"/gpio/*.{py,sh}
chmod +x "$BASE"/gpio/exec/* #glob not in string
chmod +x "$BASE"/gpio/exec/button-led/*




section '7. Setting Wallpaper and Splash Screen'
# Set splash screen for when raspberry pi is booting
SPLASH_DIR="/usr/share/plymouth/themes/pix"
[ -e "$SPLASH_DIR/splash.png" ] && sudo mv "$SPLASH_DIR/splash.png" "$SPLASH_DIR/splash.png.bak" #backup splash saver
sudo cp "$BASE/theme/splash.png" "$SPLASH_DIR/splash.png"

# Set desktop wallpaper
sudo unlink /etc/alternatives/desktop-background #these two lines should do it in other versions
sudo ln -s "$BASE/themes/desktop background.png" /etc/alternatives/desktop-background
pcmanfm --set-wallpaper "$BASE/theme/desktop background.png" #this usu does it in my raspis





section '8. Finishing Up'

# Source jkiosk.sh on every terminal window opened (session startup)
grep -q '# JKiosk' < "$HOME/.bashrc" && WARN "There are duplicate records of JKiosk in ~/.bashrc. Remove one."
echo "
# JKiosk
source '$BASE/system/jkiosk.sh'
" >> "$HOME/.bashrc"

source ~/.bashrc #source for this session so command accessible now



# Git
git config --global user.name "Joel Grayson"
git config --global user.email joel@joelgrayson.com





section '9. Starting up kiosk mode!'
sleep 6 #daemon needs a while before starting
sudo systemctl enable kiosk.service #means the kiosk will automatically turn into kiosk mode on reboot
sleep 4
sudo systemctl start kiosk.service
if command_exists "jkiosk"; then
    jkiosk follow-todays-schedule
else
    echo "Run \`jkiosk follow-todays-schedule\` in a new terminal"
fi
