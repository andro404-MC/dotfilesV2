#!/bin/bash
BAT="/sys/class/power_supply/BAT0"
if [ ! -d "$BAT" ]; then printf '{"text":"","tooltip":""}'; exit 0; fi
cap=$(cat "$BAT/capacity" 2>/dev/null)
status=$(cat "$BAT/status" 2>/dev/null)
if [ -z "$cap" ]; then printf '{"text":"","tooltip":""}'; exit 0; fi

icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
idx=$((cap / 10)); [ "$idx" -gt 9 ] && idx=9
icon="${icons[$idx]}"
case "$status" in
  Charging) icon="󱐋" ;;
  "Not charging") icon="" ;;
esac

if [ "$status" = "Full" ]; then
  text=$(printf '<span color="#7aa2f7">%s</span> full' "$icon")
else
  text=$(printf '<span color="#7aa2f7">%s</span> %s%%' "$icon" "$cap")
fi

tooltip=""
enow=$(cat "$BAT/energy_now" 2>/dev/null)
efull=$(cat "$BAT/energy_full" 2>/dev/null)
pnow=$(cat "$BAT/power_now" 2>/dev/null)
if [ -n "$enow" ] && [ -n "$efull" ] && [ -n "$pnow" ] && [ "${pnow#-}" -gt 0 ] 2>/dev/null; then
  if [ "$status" = "Charging" ]; then
    mins=$(( (efull - enow) * 60 / ${pnow#-} ))
  else
    mins=$(( enow * 60 / ${pnow#-} ))
  fi
  if [ "$mins" -ge 60 ]; then
    tooltip=$(printf '%dh %dm' $((mins/60)) $((mins%60)))
  else
    tooltip="${mins}m"
  fi
  if [ "$status" = "Charging" ]; then
    tooltip="$tooltip until full"
  else
    tooltip="$tooltip remaining"
  fi
fi

jq -cn --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'
