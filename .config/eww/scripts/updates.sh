#!/bin/bash
CACHE="$HOME/.cache/eww-updates.json"
STALE_AFTER=3600

refresh() {
  timeout 60 waybar-module-pacman-updates --no-zero-output --interval-seconds 900 \
    --color-semver-updates f7567e,9ece6a,7aa2f7,C5C8C6,707880 > "$CACHE.tmp" 2>/dev/null
  mv "$CACHE.tmp" "$CACHE"
}

if [ ! -f "$CACHE" ] || [ $(( $(date +%s) - $(stat -c %Y "$CACHE") )) -gt $STALE_AFTER ]; then
  ( refresh ) &
fi

if [ -f "$CACHE" ] && [ "$(jq -r '.class // empty' "$CACHE" 2>/dev/null)" = "has-updates" ]; then
  printf '<span color="#f7567e">󱍷 </span>'
fi
