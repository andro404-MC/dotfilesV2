#!/bin/bash
# deflisten source for backlight: print current state, then re-emit on udev
# change events. The while/sleep wrapper self-heals subscription drops.
STATE="/home/untemi/.config/eww/scripts/backlight.sh"
emit() { printf '%s\n' "$("$STATE")"; }
while true; do
  emit
  udevadm monitor --subsystem-match=backlight 2>/dev/null | while IFS= read -r ev; do
    case "$ev" in
      *"] change"*) emit ;;
    esac
  done
  sleep 1
done
