#!/bin/bash
# deflisten source for keyboard layout: print current state, then re-emit on each
# sway input event. The while/sleep wrapper self-heals subscription drops.
STATE="/home/untemi/.config/eww/scripts/language.sh"
emit() { printf '%s\n' "$("$STATE")"; }
while true; do
  emit
  swaymsg -t subscribe -m '["input"]' 2>/dev/null | while IFS= read -r _; do
    emit
  done
  sleep 1
done
