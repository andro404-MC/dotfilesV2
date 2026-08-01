#!/bin/bash
read -r tot used < <(free -m 2>/dev/null | awk '/^Mem:/ {print $2, $3}')
if [ -z "$tot" ]; then printf '{"text":"","tooltip":""}'; exit 0; fi
pct=$((used * 100 / tot))
text=$(printf '<span color="#7aa2f7">󰍛</span>  %s%%' "$pct")
tooltip=$(awk -v u="$used" -v t="$tot" 'BEGIN {printf "Used %.1fG / %.1fG", u/1024, t/1024}')
jq -cn --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'
