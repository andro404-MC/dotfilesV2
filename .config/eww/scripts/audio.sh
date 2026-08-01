#!/bin/bash
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '/^Volume:/ {printf "%.0f", $2*100}')
if [ -z "$vol" ]; then printf '{"text":"","tooltip":""}'; exit 0; fi

case "$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null)" in
  *yes*) text=$(printf '󰝟  %s%%' "$vol") ;;
  *)
    if [ "$vol" -le 33 ]; then icon="󰕿"; elif [ "$vol" -le 66 ]; then icon="󰖀"; else icon="󰕾"; fi
    text=$(printf '<span color="#f7567e">%s</span>  %s%%' "$icon" "$vol") ;;
esac

tooltip=$(pactl list sinks 2>/dev/null | awk -v d="$(pactl get-default-sink 2>/dev/null)" '
  $1=="Name:" && $2==d {found=1; next}
  found && /^[[:space:]]*Description:/ {sub(/^[[:space:]]*Description:[[:space:]]*/, ""); print; exit}')

jq -cn --arg text "$text" --arg tooltip "$tooltip" '{text:$text, tooltip:$tooltip}'
