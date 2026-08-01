#!/bin/bash
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '/^Volume:/ {printf "%.0f", $2*100}')
[ -z "$vol" ] && exit 0
case "$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null)" in
  *yes*)
    printf '󰝟  %s%%' "$vol"; exit 0 ;;
esac
if [ "$vol" -le 33 ]; then icon="󰕿"; elif [ "$vol" -le 66 ]; then icon="󰖀"; else icon="󰕾"; fi
printf '<span color="#f7567e">%s</span>  %s%%' "$icon" "$vol"
