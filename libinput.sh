#!/bin/bash


HOSTNAME=`hostname`
if [[ $HOSTNAME = "ryzef.lan.zero9f9.com" || $HOSTNAME = "u22.lan.zero9f9.com" ]] ; then
  echo "u22"
    xinput set-prop "Logitech Gaming Mouse G502" "libinput Accel Speed" 0.4
elif [[ $HOSTNAME = "fx270.lan.zero9f9.com" ]] ; then
    xinput set-prop 12 "libinput Accel Speed" -0.6
    xinput disable 11
else
    xinput set-prop 11 "libinput Accel Speed" -0.6
fi
