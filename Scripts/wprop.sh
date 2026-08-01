#! /usr/bin/env bash
SWAY_TREE=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?)')

# Invoke slurp to let the user select a window
SELECTION=$(printf '%s\n' "$SWAY_TREE" | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
[[ -z "$SELECTION" ]] && exit 0

# Extract the X, Y, Width, and Height from the selection
X=$(printf '%s' "$SELECTION" | awk -F'[, x]' '{print $1}')
Y=$(printf '%s' "$SELECTION" | awk -F'[, x]' '{print $2}')
W=$(printf '%s' "$SELECTION" | awk -F'[, x]' '{print $3}')
H=$(printf '%s' "$SELECTION" | awk -F'[, x]' '{print $4}')

# Find the window matching the selection
printf '%s\n' "$SWAY_TREE" | jq -r --argjson x "$X" --argjson y "$Y" --argjson w "$W" --argjson h "$H" \
  '. | select(.rect.x == $x and .rect.y == $y and .rect.width == $w and .rect.height == $h)'
