#!/bin/bash

xrandr --output DP-4 --auto --primary --output DP-3 --mode 3440x1440 --rate 60.00 --left-of DP-4 --output DP-0 --off
sleep 5
xrandr --output DP-4 --auto --primary --output DP-3 --mode 3440x1440 --rate 99.99 --left-of DP-4 --output DP-0 --off

exit 0
