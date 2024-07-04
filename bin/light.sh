#!/bin/bash

case "$1" in 
  "up")
    cur_brightness=$(ddcutil --display=1 getvcp 10 | awk '{print $9}' | sed -e 's/,//g')
    ddcutil --display=1 setvcp 10 $(($cur_brightness + 10))
    cur_brightness=$(ddcutil --display=2 getvcp 10 | awk '{print $9}' | sed -e 's/,//g')
    ddcutil --display=2 setvcp 10 $(($cur_brightness + 10))
    hyprctl notify 1 3000 "rgb(ff1ea3)" "brightness: $cur_brightness"
  ;;
  "down")
    cur_brightness=$(ddcutil --display=1 getvcp 10 | awk '{print $9}' | sed -e 's/,//g')
    ddcutil --display=1 setvcp 10 $(($cur_brightness - 10))
    cur_brightness=$(ddcutil --display=2 getvcp 10 | awk '{print $9}' | sed -e 's/,//g')
    ddcutil --display=2 setvcp 10 $(($cur_brightness - 10))
    hyprctl notify 1 3000 "rgb(ff1ea3)" "brightness: $cur_brightness"
  ;;
esac

