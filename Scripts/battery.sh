#! /usr/bin/env bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))
(( icon_index > 9 )) && icon_index=9

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [[ "$battery_status" = "Charging" || "$battery_status" = "Full" ]]; then
  battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_percentage% $battery_icon"
