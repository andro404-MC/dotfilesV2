#!/bin/bash

swayidle -w timeout 10 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' &
SWAYIDLE_PID=$!

# gtklock --idle-hide --idle-timeout 10
hyprlock

kill $SWAYIDLE_PID
exit
