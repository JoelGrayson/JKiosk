#!/bin/bash

# 1. fetch from remote server
# 2. interpret times
# 3. add to log file in ~/JKiosk/on-logs.txt

jdate() {
    dayOfMonth=$(($(date +'%d')))
    month=$(($(date +'%m')))
    fullYear="$(date +'%Y')" #four chars long
    year="${fullYear:2:4}" #last two chars (2021 -> 21)

    echo "$month.$dayOfMonth.$year" #eg 11.3.22
}

url="https://buseroo.com/api/kiosk/on-times?institution=INSTITUTION_INSERTED_HERE_BY_INSTALL_SH&date=$(jdate)"
curl "$url" | "BASE_INSERTED_HERE_BY_INSTALL_SH/system/interpret_times.pl"
