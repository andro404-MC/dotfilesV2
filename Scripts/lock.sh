#!/bin/bash


if [[ $XDG_CURRENT_DESKTOP == "Hyprland"  ]]; then
  swayidle -w timeout 10 'hyprctl dispatch dpms off' \
              resume 'hyprctl dispatch dpms on' &
elif [[ $XDG_CURRENT_DESKTOP == "sway" ]]; then
  swayidle -w timeout 10 'swaymsg "output * power off"' \
              resume 'swaymsg "output * power on"' &
fi

SWAYIDLE_PID=$!

# gtklock --idle-hide --idle-timeout 10
hyprlock

kill $SWAYIDLE_PID
exit
