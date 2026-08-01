#!/bin/bash
read -r size used pct < <(df -h -P / 2>/dev/null | awk 'NR==2 {gsub("%","",$5); print $2, $3, $5}')
if [ -z "$pct" ]; then printf '{"text":"","tooltip":""}'; exit 0; fi
text=$(printf '<span color="#7aa2f7">󰋊</span>  %s%%' "$pct")
tooltip=$(printf 'Used %s / %s' "$used" "$size")
jq -cn --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'
