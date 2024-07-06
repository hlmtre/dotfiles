#!/bin/bash

case "$1" in 
  "up")
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    hyprctl notify 1 3000 "rgb(ff1ea3)" $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
  ;;
  "down")
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    hyprctl notify 1 3000 "rgb(ff1ea3)" $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
  ;;
esac

