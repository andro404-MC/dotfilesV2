#!/bin/bash
# deflisten source for audio: print current state, then re-emit on sink/server
# changes. The while/sleep wrapper self-heals subscription drops.
STATE="/home/untemi/.config/eww/scripts/audio.sh"
emit() { printf '%s\n' "$("$STATE")"; }
while true; do
  emit
  pactl subscribe 2>/dev/null | while IFS= read -r ev; do
    case "$ev" in
      *"'change' on sink"*|*"'change' on server"*) emit ;;
    esac
  done
  sleep 1
done
