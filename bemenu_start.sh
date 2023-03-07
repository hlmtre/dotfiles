#!/bin/sh

# first, get all the get all the outputs - swaymsg -t get_outputs
# then, get the focused output with rg
# get just the second word (Output >>> HDMI-A-2 <<<)
# reverse the string so it's 2-A-HDMI (if this were 02, it'd get 02)
# split on '-' and get the first instance - 2 (if this were now 20, since it's reversed)
# reverse it again so it's 02, not 20
# all this to get the index of the currently focused monitor in wayland
#MONITOR=$(swaymsg -p -t 'get_outputs' | /home/hlmtre/.cargo/bin/rg 'focused' | awk '{print $2}' | rev | cut -d'-' -f1 | rev)
# -1 is always focused monitor ffs
bemenu-run -l 20 -w 0.2 -p 'run:' -m -1 | xargs swaymsg exec
