#!/bin/bash
# ABOUT: This file is located at http://buseroo.com/JKiosk/install.sh
# Last updated 10.7.22
# Created 11.2021
VERSION="1.0"


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



# Check if JKiosk already exists
[ -d "$HOME/JKiosk" ] && ERR 'JKiosk already installed'






section '1. Preparing'

sudo apt-get update
sudo apt-get upgrade -y
# <gum> Install gum for question
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
# </gum>
sudo apt purge -y smartsim java-common wolfram-engine scratch nuscratch #remove unnecessary packages
# sudo apt purge -y libreoffice* scratch2 remove other unnecessary packages
sudo apt clean -y
sudo apt autoremove -y
sudo apt-get install -y vim unclutter sed #install needed packages
    # sed for kiosk.service parsing
    # unclutter to hide the cursor





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
institution="$(echo "$institutions" | gum filter || echo "$default_institution")"
[ -z "$institution" ] && institution="$default_institution" #default
echo "Selected \"$(tput bold)$institution$(tput sgr0)\" as institution."





section '3. What Group Are You?'
printf "\nHere are a list of all the groups:\n$(groups)\n"
user_group="$(gum input --prompt "What group is this user in (probably $(whoami))? ")"






section '4. Clone JKiosk from GitHub'

git clone https://github.com/JoelGrayson/JKiosk.git || ERR 'Could not clone git repository'
BASE="$HOME/JKiosk"
cd "$BASE" || ERR 'Could not install JKiosk properly'





section '5. Expanding *_INSERTED_HERE_BY_INSTALL_SH Values' # Filling in values in files because they cannot expand values such as ~ or $(whoami)
# kiosk.service
old_text_end="INSERTED_HERE_BY_INSTALL_SH"
sed -i "s;HOME_$old_text_end;$HOME;g" "$BASE/exec/system/kiosk.service" #; separator so path (/) not confused with separator
sed -i "s;BASE_$old_text_end;$BASE;g" "$BASE/exec/system/kiosk.service"
sed -i "s;USERNAME_$old_text_end;$(whoami);g" "$BASE/exec/system/kiosk.service"
sed -i "s;GROUP_$old_text_end;$user_group;g" "$BASE/exec/system/kiosk.service" #user specified group earlier
# cronjobs
sed -i "s;HOME_$old_text_end;$HOME;g" "$BASE/exec/system/cronjobs"
# kiosk.sh
sed -i "s;HOME_$old_text_end;$HOME;g" "$BASE/exec/system/kiosk.sh"
sed -i "s;INSTITUTION_$old_text_end;$institution;g" "$BASE/exec/system/kiosk.sh"
# jkiosk.sh
sed -i "s;DATE_$old_text_end;$(date);g" "$BASE/exec/system/jkiosk.sh"
sed -i "s;VERSION_$old_text_end;$VERSION;g" "$BASE/exec/system/jkiosk.sh"





section '6. Processing JKiosk Files' # Moves files to correct locations

# sudo cp "$BASE/exec/system/kiosk.service" "/usr/lib/systemd/system" || ERR "can't move kiosk.service"
sudo cp "$BASE/exec/system/kiosk.service" "/lib/systemd/system/kiosk.service" || ERR "can't move kiosk.service"
crontab "$BASE/exec/system/cronjobs" #sets cronjobs as the new crontab so turns on/off at right times and turns on kiosk on boot

# Make files executable
chmod +x "$BASE/exec/system/kiosk.sh"
chmod +x "$BASE/exec/system/jkiosk.sh"
chmod +x "$BASE/exec/relay/HIGH"
chmod +x "$BASE/exec/relay/LOW"





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
source '$BASE/exec/system/jkiosk.sh'
" >> "$HOME/.bashrc"
source "$BASE/exec/system/jkiosk.sh" #source for this session


# Git
git config --global user.name "Joel Grayson"
git config --global user.email joel@joelgrayson.com





section '9. Starting up kiosk mode!'
sleep 8 #daemon needs a while before starting
sudo systemctl enable kiosk.service #means the kiosk will automatically turn into kiosk mode on reboot
sleep 5
sudo systemctl start kiosk.service


