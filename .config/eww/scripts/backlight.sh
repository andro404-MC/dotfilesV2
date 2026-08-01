#!/bin/bash
pct=$(brightnessctl -m 2>/dev/null | awk -F, '{print $4}' | tr -d '%')
[ -z "$pct" ] && exit 0
icons=("󰃞" "󰃝" "󰃟" "󰃠")
idx=$((pct * 4 / 100)); [ "$idx" -gt 3 ] && idx=3
printf '<span color="#f7567e" size="10pt" rise="500">%s</span>  %s%%' "${icons[$idx]}" "$pct"
