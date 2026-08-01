#!/bin/bash
layout=$(setxkbmap -query 2>/dev/null | awk '/^layout:/ {print $2; exit}')
[ -z "$layout" ] && exit 0
short=$(awk -v l="$layout" '
  BEGIN { RS = "<layout>" }
  match($0, /<name>([^<]+)<\/name>/, m) {
    if (m[1] == l) {
      if (match($0, /<shortDescription>([^<]+)<\/shortDescription>/, s)) { print s[1]; }
      exit;
    }
  }' /usr/share/X11/xkb/rules/evdev.xml)
[ -z "$short" ] && short="$layout"
printf '%s' "$short"
