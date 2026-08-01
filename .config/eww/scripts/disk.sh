#!/bin/bash
pct=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')
printf '<span color="#7aa2f7">󰋊</span>  %s%%' "$pct"
