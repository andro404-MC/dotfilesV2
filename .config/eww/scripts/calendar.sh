#!/bin/bash
year=$(date +%Y)
month=$(date +%-m)
today=$(date +%-d)
title=$(date '+%A %B %Y')
first_wd=$(date -d "$year-$month-01" +%u)
days=$(date -d "$year-$month-01 +1 month -1 day" +%d)

if [ "$month" -eq 1 ]; then prev_m=12; prev_y=$((year-1)); else prev_m=$((month-1)); prev_y=$year; fi
if [ "$month" -eq 12 ]; then next_m=1; next_y=$((year+1)); else next_m=$((month+1)); next_y=$year; fi
prev_days=$(date -d "$prev_y-$prev_m-01 +1 month -1 day" +%d)

cells=()
for ((i=1; i<first_wd; i++)); do
  cells+=("$((prev_days - first_wd + 1 + i)):1")
done
for ((d=1; d<=days; d++)); do
  cells+=("$d:0")
done
n=1
while (( ${#cells[@]} % 7 != 0 )); do
  cells+=("$n:1"); n=$((n+1))
done

weeks_json="["
for ((i=0; i<${#cells[@]}; i+=7)); do
  [ "$i" -gt 0 ] && weeks_json+=","
  weeks_json+="["
  for ((j=i; j<i+7; j++)); do
    [ "$j" -gt "$i" ] && weeks_json+=","
    cell="${cells[$j]}"
    num="${cell%%:*}"
    oth="${cell##*:}"
    if [ "$oth" -eq 1 ]; then o="true"; else o="false"; fi
    if [ "$oth" -eq 0 ] && [ "$num" -eq "$today" ]; then t="true"; else t="false"; fi
    weeks_json+="{\"d\":$num,\"t\":$t,\"o\":$o}"
  done
  weeks_json+="]"
done
weeks_json+="]"

jq -n --arg title "$title" --argjson today "$today" --argjson weeks "$weeks_json" \
  '{title: $title, today: $today, weeks: $weeks}'
