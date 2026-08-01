#! /usr/bin/env bash

SWAYIDLE_PID=""

cleanup() {
  [[ -n "$SWAYIDLE_PID" ]] && kill "$SWAYIDLE_PID" 2>/dev/null
}

trap cleanup EXIT INT TERM

if [[ $XDG_CURRENT_DESKTOP =~ ^Hyprland ]]; then
  swayidle -w timeout 10 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' &
  SWAYIDLE_PID=$!
elif [[ $XDG_CURRENT_DESKTOP =~ ^sway ]]; then
  swayidle -w timeout 10 'swaymsg "output * power off"' \
    resume 'swaymsg "output * power on"' &
  SWAYIDLE_PID=$!
fi

pkill -x hyprlock 2>/dev/null || true
hyprlock --no-fade-in -q
