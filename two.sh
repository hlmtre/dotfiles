#!/bin/sh
xrandr --output DP-4 --primary --rate 143.91 --mode 2560x1440 --output DP-0 --mode 3440x1440 --rate 100.00 --left-of DP-4
sleep 5
i3-resurrect restore -w 1irc
i3-resurrect restore -w 2web
i3-resurrect restore -w 3cli
i3-resurrect restore -w 4vpn
i3-resurrect restore -w e
