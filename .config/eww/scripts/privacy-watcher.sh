#!/bin/bash
# deflisten source for privacy. Two triggers, both deduped so the bar only
# repaints when the privacy state actually changes (no periodic refresh):
#   - pactl subscribe: instant mic updates (source-output new/change/remove)
#   - 5s poll: catches screen recording (PipeWire node, ~36ms pw-dump) and
#     direct-V4L2 camera use, which have no cheap event source
# Each check re-runs privacy.sh (one-shot pw-dump + fuser) and emits only when
# the resulting JSON differs from the previous emit.
STATE="/home/untemi/.config/eww/scripts/privacy.sh"
prev=""
check() {
  cur=$("$STATE")
  if [ "$cur" != "$prev" ]; then
    prev="$cur"
    printf '%s\n' "$cur"
  fi
}

emit_initial() { prev=$("$STATE"); printf '%s\n' "$prev"; }
emit_initial

( while true; do
    pactl subscribe 2>/dev/null | while IFS= read -r ev; do
      case "$ev" in
        *"source-output"*|*"'change' on sink"*|*"'change' on server"*) check ;;
      esac
    done
    sleep 1
  done ) &

while true; do
  sleep 5
  check
done
