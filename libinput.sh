#!/bin/bash


HOSTNAME=`hostname`
if [[ $HOSTNAME = "ryzef.lan.zero9f9.com" ]] ; then
    xinput set-prop 11 "libinput Accel Speed" 0
else
    xinput set-prop 11 "libinput Accel Speed" -0.6
fi
