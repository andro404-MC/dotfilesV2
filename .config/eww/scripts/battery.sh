#!/bin/bash
BAT="/sys/class/power_supply/BAT0"
[ -d "$BAT" ] || exit 0
cap=$(cat "$BAT/capacity" 2>/dev/null)
[ -z "$cap" ] && exit 0
status=$(cat "$BAT/status" 2>/dev/null)
icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
idx=$((cap / 10)); [ "$idx" -gt 9 ] && idx=9
icon="${icons[$idx]}"
case "$status" in
  Charging) icon="󱐋" ;;
  "Not charging") icon="" ;;
  Full) printf '<span color="#7aa2f7">%s</span> full' "$icon"; exit 0 ;;
esac
printf '<span color="#7aa2f7">%s</span> %s%%' "$icon" "$cap"
