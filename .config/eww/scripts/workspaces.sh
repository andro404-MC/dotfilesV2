#!/bin/bash
swaymsg -t get_workspaces -r | jq -c '[.[] | {
  num: .num,
  name: .name,
  focused: .focused,
  urgent: .urgent,
  display: (if .num > 0 then ({ "1": "一", "2": "二", "3": "三", "4": "四", "5": "五", "6": "六", "7": "七", "8": "八", "9": "九", "10": "十" }[.num | tostring] // .name) else .name end)
}] | sort_by(.num)'
