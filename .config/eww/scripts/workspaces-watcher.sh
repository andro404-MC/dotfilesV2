#!/bin/bash
# deflisten source for workspaces: print current state, then re-emit on each
# sway workspace/window event. The while/sleep wrapper self-heals subscription drops.
STATE="/home/untemi/.config/eww/scripts/workspaces.sh"
emit() { printf '%s\n' "$("$STATE")"; }
while true; do
  emit
  swaymsg -t subscribe -m '["workspace", "window"]' 2>/dev/null | while IFS= read -r _; do
    emit
  done
  sleep 1
done
