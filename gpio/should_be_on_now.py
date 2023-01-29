#!/usr/bin/env python

import json
import re
from datetime import datetime


def get_now(): #string time
    return datetime.now().strftime('%H:%M')

def parse_time(time): #string -> tuple ∵ tuple can do gt lt operations
    hours=int(re.match(r'(\d{1,2}):(\d{1,2})', time).group(1)) #type: ignore
    minutes=int(re.match(r'(\d{1,2}):(\d{1,2})', time).group(2)) #type: ignore
    return (hours, minutes)

def time_gte(time1, time2): #both strings returns bool (hour:minute)
    return parse_time(time1)>=parse_time(time2)


def should_be_on_now(): #assumes times are in order from earliest to latest
    with open('BASE_INSERTED_HERE_BY_INSTALL_SH/system/todays-schedule.json') as f: #../system/todays-schedule.json
        schedule=json.load(f)
        now=get_now()
        should_be=False
        for buff in schedule:
            action=buff['action']
            time=buff['time']
            if time_gte(now, time):
                should_be=action
            else:
                break
        return should_be

if __name__=='__main__':
    print(should_be_on_now())
