#!/bin/bash

arg=$1

case $arg in 
  kb_disable)
    swaymsg "input 1:1:AT_Translated_Set_2_keyboard events disabled"
  ;;
  kb_enable)
    swaymsg "input 1:1:AT_Translated_Set_2_keyboard events enabled"
  ;;
  touchpad_enable)
    swaymsg  "input 2:7:SynPS/2_Synaptics_TouchPad  events enabled"
  ;;
  touchpad_disable)
    swaymsg  "input 2:7:SynPS/2_Synaptics_TouchPad  events disabled"
  ;;
esac

