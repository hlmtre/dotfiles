#!/bin/sh

# first, get all the get all the outputs - swaymsg -t get_outputs
# then, get the focused output with rg
# get just the second word (Output >>> HDMI-A-2 <<<)
MONITOR=$(swaymsg -p -t 'get_outputs' | /home/hlmtre/.cargo/bin/rg 'focused' | awk '{print $2}')
wofi --monitor $MONITOR --show run
