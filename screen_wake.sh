#!/bin/bash

xrandr --output HDMI-0 --auto --primary --output DP-3 --mode 3440x1440 --rate 60.00 --left-of HDMI-0 --output DP-0 --off
sleep 5
xrandr --output HDMI-0 --auto --primary --output DP-3 --mode 3440x1440 --rate 99.99 --left-of HDMI-0 --output DP-0 --off

exit 0
