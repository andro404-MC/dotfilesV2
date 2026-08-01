#!/bin/bash
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '/^Volume:/ {printf "%.0f", $2*100}')
if [ -z "$vol" ]; then printf '{"text":"","tooltip":""}'; exit 0; fi

desc=$(pactl list sinks 2>/dev/null | awk -v d="$(pactl get-default-sink 2>/dev/null)" '
  $1=="Name:" && $2==d {found=1; next}
  found && /^[[:space:]]*Description:/ {sub(/^[[:space:]]*Description:[[:space:]]*/, ""); print; exit}')

name="$desc"
if [ -n "$name" ]; then
  name=$(printf '%s' "$name" | sed 's/([^)]*)//g' | tr -s ' ')
  n=$(printf '%s' "$name" | wc -w)
  last=$(printf '%s' "$name" | awk '{print $NF}')
  if [[ "$last" =~ ^[0-9]+$ ]] && [ "$n" -gt 1 ]; then
    name=$(printf '%s' "$name" | awk '{print $(NF-1), $NF}')
  else
    name="$last"
  fi
fi

case "$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null)" in
  *yes*) text=$(printf '󰝟  %s%%' "$vol") ;;
  *)
    if [ "$vol" -le 33 ]; then icon="󰕿"; elif [ "$vol" -le 66 ]; then icon="󰖀"; else icon="󰕾"; fi
    text=$(printf '<span color="#f7567e">%s</span>  %s%%' "$icon" "$vol") ;;
esac

jq -cn --arg text "$text" --arg tooltip "$name" '{text:$text, tooltip:$tooltip}'
