#!/bin/bash
pct=$(free | awk '/^Mem:/ {printf "%d", $3/$2*100}')
printf '<span color="#7aa2f7">󰍛</span>  %s%%' "$pct"
