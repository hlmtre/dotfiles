#!/bin/sh
#xrandr --output DP-0 --primary --rate 143.91 --mode 2560x1440 --output DP-0 --mode 3440x1440 --rate 100.00 --left-of DP-2
xrandr --output DP-4 --primary --mode 2560x1440 --rate 143.91 --output DP-2 --auto --left-of DP-4
#sleep 5
#i3-resurrect restore -w 1:irc
#i3-resurrect restore -w 2:web
#i3-resurrect restore -w 3:cli
#i3-resurrect restore -w 4:vpn
#i3-resurrect restore -w e
